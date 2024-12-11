//
//  ChosenFinanceViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class ChosenFinanceViewController: NSSplitViewController {
    
    private let navbar = FinanceNavigationController()
    private let financeInfo = FinanceInfoViewController()
    
    private var navbarItem: NSSplitViewItem?
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
        
        navbarItem = NSSplitViewItem(sidebarWithViewController: navbar)
        infoItem = NSSplitViewItem(viewController: financeInfo)
        
        navbarItem?.minimumThickness = 50
        navbarItem?.maximumThickness = 60
        
        infoItem?.minimumThickness = 500
    }
    
    private func setupHierarchy() {
        addSplitViewItem(navbarItem!)
        addSplitViewItem(infoItem!)
    }
}
