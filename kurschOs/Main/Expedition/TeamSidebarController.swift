//
//  TeamSidebarController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 05.12.2024.
//

import Cocoa

final class TeamSidebarController: NSViewController {
    
    private var items: [(name: String, surname: String)] = [
//        ("Ivan", "Petrov"),
//        ("Vasilii", "Pushev")
    ]
    
    private var reseachers: [Researcher] = []
    
    private lazy var table = NSTableView()
    
    private lazy var addButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = .systemGreen
        button.target = self
        button.action = #selector(addButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "arrow.uturn.backward", accessibilityDescription: nil)
        button.bezelColor = NSColor.orange
        button.target = self
        button.action = #selector(backButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let colum = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("ColumIdentifier"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
        fetchReseachers()
    }
    
    private func configure() {
        colum.width = 200
        table.addTableColumn(colum)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        view.addSubview(addButton)
        view.addSubview(backButton)
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            table.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 5),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
        ])
    }
    
    private func fetchReseachers() {
        guard let team = MainDataManager.shared.team else { return }
        
        items.removeAll()
        
        reseachers = ResearcherDataManger.shared.fetchAllResearchersByTeam(team: team)
        
        if !reseachers.isEmpty {
            
            for i in 0..<reseachers.count {
                
                items.append((reseachers[i].fisrtName!, reseachers[i].lastName!))
            }
        }
        
        table.reloadData()
    }
    
    @objc
    private func addButtonTapped() {
        let vc = CreateResearcherViewController()

        guard let team = MainDataManager.shared.team else { return }

        vc.team = team
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
    
    @objc
    private func backButtonTapped() {
        let vc = ChosenExpeditionController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension TeamSidebarController: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        let cell = ResearcherCell()
        
        let data = items[row]
        
        cell.setName(data.name)
        cell.setSurname(data.surname)
        
        return cell
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 50
    }
}

extension TeamSidebarController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchReseachers()
    }
}
