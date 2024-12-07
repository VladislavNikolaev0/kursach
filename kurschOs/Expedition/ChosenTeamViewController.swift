//
//  ChosenTeamViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 05.12.2024.
//

import Cocoa

final class ChosenTeamViewController: NSSplitViewController {
    
    private let sidebarController = TeamSidebarController()
    private let researchreViewController = ResearcherViewController()
    
    private var sidebarItem: NSSplitViewItem?
    private var researcherItem: NSSplitViewItem?
    
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
        
        sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarController)
        researcherItem = NSSplitViewItem(viewController: researchreViewController)
        
        sidebarItem?.minimumThickness = 200
        sidebarItem?.maximumThickness = 230
        
        researcherItem?.minimumThickness = 600
    }
    
    private func setupHierarchy() {
        addSplitViewItem(sidebarItem!)
        addSplitViewItem(researcherItem!)
    }
}

