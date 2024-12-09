//
//  ExpeditionListViewContrller.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ExpeditionListViewController: NSViewController {
    
    private var project: Project? = MainDataManager.shared.project
    private var expeditions: [Expedition] = []
    
    private lazy var addExpeditionButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addExpeditionButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalScrollView: NSScrollView = {
        let scroll = NSScrollView()
        scroll.hasVerticalScroller = true
        scroll.hasHorizontalScroller = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        fetchExpeditions()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalScrollView)
        view.addSubview(addExpeditionButton)
        verticalScrollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addExpeditionButton.topAnchor.constraint(equalTo: view.topAnchor),
            addExpeditionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addExpeditionButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchExpeditions() {
        
        guard let project = MainDataManager.shared.project else { return }
        
        expeditions = ExpeditionDataManger.shared.fetchAllExpeditionByProject(project: project)
        
        if !expeditions.isEmpty {

            var newCellExpedition = ExpeditionCell(
                expeditionName: expeditions[0].expeditionName!,
                startDate: "\(expeditions[0].startDate!)",
                endDate: "\(expeditions[0].endDate!)",
                type: expeditions[0].expeditionType!,
                mainGoal: expeditions[0].mainGoal!
            )
            
            newCellExpedition.deleaget = self
            newCellExpedition.expedition = expeditions[0]
            
            contentView.addSubview(newCellExpedition)
            
            NSLayoutConstraint.activate([
                
                newCellExpedition.topAnchor.constraint(equalTo: contentView.topAnchor),
                newCellExpedition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newCellExpedition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newCellExpedition.heightAnchor.constraint(equalToConstant: 145),
            ])
            
            if expeditions.count > 1 {
                
                for i in 1..<expeditions.count {
                    
                    let cellExpedition = ExpeditionCell(
                        expeditionName: expeditions[i].expeditionName!,
                        startDate: "\(expeditions[i].startDate!)",
                        endDate: "\(expeditions[i].endDate!)",
                        type: expeditions[i].expeditionType!,
                        mainGoal: expeditions[i].mainGoal!
                    )
                    
                    cellExpedition.deleaget = self
                    cellExpedition.expedition = expeditions[i]
                    
                    contentView.addSubview(cellExpedition)
                    
                    NSLayoutConstraint.activate([
                        
                        cellExpedition.topAnchor.constraint(equalTo: newCellExpedition.bottomAnchor),
                        cellExpedition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellExpedition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellExpedition.heightAnchor.constraint(equalToConstant: 145),
                    ])
                    
                    newCellExpedition = cellExpedition
                }
            }
        }
    }
    
    @objc
    private func addExpeditionButtonTapped() {
        let vc = CreateExpeditionViewController()
        print("1")
        guard let project = MainDataManager.shared.project else { return }
        print("2")
        vc.project = project
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension ExpeditionListViewController: ExpeditionCellDelegate {
    
    func dedSelectCell(_ cell: ExpeditionCell) {
        let vc = ChosenExpeditionController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }

}

extension ExpeditionListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchExpeditions()
    }
}
