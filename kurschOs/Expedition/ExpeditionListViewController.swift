//
//  ExpeditionListViewContrller.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ExpeditionListViewController: NSViewController {
    
    private lazy var testExpedition = ExpeditionCell(
        expeditionName: "Terraria",
        startDate: "12.12.24",
        endDate: "12.12.25",
        type: "Geo",
        mainGoal: "How to mach we can still a shit and need a more text for testing this block"
    )
    
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
        addCell()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
        view.addSubview(testExpedition)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func addCell() {
        contentView.addSubview(testExpedition)
        
        NSLayoutConstraint.activate([
            testExpedition.topAnchor.constraint(equalTo: contentView.topAnchor),
            testExpedition.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            testExpedition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testExpedition.heightAnchor.constraint(equalToConstant: 145),
        ])
        
        testExpedition.deleaget = self
    }
}

extension ExpeditionListViewController: ExpeditionCellDelegate {
    
    func dedSelectCell(_ cell: ExpeditionCell) {
        let vc = ChosenExpeditionController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }

}
