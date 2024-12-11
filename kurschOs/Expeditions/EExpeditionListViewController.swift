//
//  EExpeditionListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class EExpeditionListViewController: NSViewController {
    
    private var eexpeditions: [EExpedition] = []
    
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
        
        guard let eproject = MainExpeditonDataManager.shared.project else { return }
        
        eexpeditions = EExpeditionDataManager.shared.fetchAllExpeditionByProject(eproject: eproject)
        let expeditions = ExpeditionDataManger.shared.fetchAllExpeditionByProject(project: MainDataManager.shared.project!)
        
        
        if !eexpeditions.isEmpty {

            var newCellExpedition = ExpeditionCell(
                expeditionName: eexpeditions[0].expeditionName!,
                startDate: "\(eexpeditions[0].startDate!)",
                endDate: "\(eexpeditions[0].endDate!)",
                type: eexpeditions[0].expeditionType!,
                mainGoal: eexpeditions[0].mainGoal!
            )
            
            newCellExpedition.deleaget = self
            newCellExpedition.eexpedition = eexpeditions[0]
            newCellExpedition.expedition = expeditions[0]
            
            contentView.addSubview(newCellExpedition)
            
            NSLayoutConstraint.activate([
                
                newCellExpedition.topAnchor.constraint(equalTo: contentView.topAnchor),
                newCellExpedition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newCellExpedition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newCellExpedition.heightAnchor.constraint(equalToConstant: 145),
            ])
            
            if eexpeditions.count > 1 {
                
                for i in 1..<eexpeditions.count {
                    
                    let cellExpedition = ExpeditionCell(
                        expeditionName: eexpeditions[i].expeditionName!,
                        startDate: "\(eexpeditions[i].startDate!)",
                        endDate: "\(eexpeditions[i].endDate!)",
                        type: eexpeditions[i].expeditionType!,
                        mainGoal: eexpeditions[i].mainGoal!
                    )
                    
                    cellExpedition.deleaget = self
                    cellExpedition.eexpedition = eexpeditions[i]
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
        let vc = CreateEExpeditionViewController()

        guard let project = MainDataManager.shared.project else { return }
        guard let eproject = MainExpeditonDataManager.shared.project else { return }
        
        print("Controller: \(vc)")
        print("View: \(vc.view)")
        
        vc.project = project
        vc.eproject = eproject
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }

}

extension EExpeditionListViewController: ExpeditionCellDelegate {
    
    func dedSelectCell(_ cell: ExpeditionCell) {
        let vc = ETeamsListViewController()
        
        MainDataManager.shared.expedtion = cell.expedition
        MainExpeditonDataManager.shared.expedition = cell.eexpedition
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }

}

extension EExpeditionListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchExpeditions()
    }
}

