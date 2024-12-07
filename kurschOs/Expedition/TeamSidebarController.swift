//
//  TeamSidebarController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 05.12.2024.
//

import Cocoa

final class TeamSidebarController: NSViewController {
    
    private let items: [(name: String, surname: String)] = [
        ("Ivan", "Petrov"),
        ("Vasilii", "Pushev")
    ]
    
    private lazy var table = NSTableView()
    
    private let colum = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("ColumIdentifier"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configure() {
        colum.width = 200
        table.addTableColumn(colum)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500),
        ])
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
