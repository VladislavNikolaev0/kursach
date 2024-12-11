//
//  EProjectSplitViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class EProjectSplitViewController: NSSplitViewController {
    
    private let navigationbar = EProjectNavigationbarController()
    private let contentView = EExpeditionListViewController()
    private var navigationbarItem: NSSplitViewItem?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
    }
    
    private func configure() {
        self.splitView.isVertical = false
        
        navigationbarItem = NSSplitViewItem(sidebarWithViewController: navigationbar)
        navigationbarItem?.minimumThickness = 20
        navigationbarItem?.maximumThickness = 30
    }
    
    private func setupHierarchy() {
        addSplitViewItem(navigationbarItem!)
        addSplitViewItem(NSSplitViewItem(viewController: contentView))
    }
    
}
