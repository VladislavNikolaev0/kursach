//
//  ExpedtionInfoController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class ExpedtionInfoController: NSSplitViewController {
    
    private let teamController = TeamListViewController()
    private let transportController = TransportViewController()
    private let equpmentController = EqupmentListViewController()
    
    private var teamItem: NSSplitViewItem?
    private var transportItem: NSSplitViewItem?
    private var equpmentItem: NSSplitViewItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
    }
    
    private func configure() {
        self.splitView.isVertical = true
        
        teamItem = NSSplitViewItem(viewController: teamController)
        transportItem = NSSplitViewItem(viewController: transportController)
        equpmentItem = NSSplitViewItem(viewController: equpmentController)
        
        teamItem?.minimumThickness = 400
        transportItem?.minimumThickness = 400
        equpmentItem?.minimumThickness = 400
    }
    
    private func setupHierarchy() {
        addSplitViewItem(teamItem!)
        addSplitViewItem(transportItem!)
        addSplitViewItem(equpmentItem!)
    }
}
