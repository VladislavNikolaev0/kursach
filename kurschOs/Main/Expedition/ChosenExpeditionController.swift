//
//  ChosenExpeditionController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class ChosenExpeditionController: NSSplitViewController {
    
    private let naviationbar = ExpeditionNavigationController()
    private let resultsController = ExpeditionResultsController()
    private let infoController = ExpedtionInfoController()
    
    private var navigationbarItem: NSSplitViewItem?
    private var resultsItem: NSSplitViewItem?
    private var infoItem: NSSplitViewItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
    }
    
    private func configure() {
        self.splitView.isVertical = false
        
        navigationbarItem = NSSplitViewItem(sidebarWithViewController: naviationbar)
        resultsItem = NSSplitViewItem(viewController: resultsController)
        infoItem = NSSplitViewItem(viewController: infoController)
        
        navigationbarItem?.minimumThickness = 50
        navigationbarItem?.maximumThickness = 60
        
        resultsItem?.minimumThickness = 200
        
        infoItem?.minimumThickness = 500
    }
    
    private func setupHierarchy() {
        addSplitViewItem(navigationbarItem!)
        addSplitViewItem(resultsItem!)
        addSplitViewItem(infoItem!)
    }
}
