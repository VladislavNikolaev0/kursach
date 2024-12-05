//
//  ProjectContenViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

protocol ProjectContentProtocol {
    
    func switchContent(_ viewController: NSViewController)
}

final class ProjectContentViewController: NSSplitViewController {
    
    private let navigationbar = ProjectNavigationbarController()
    private let contentView = ExpeditionListViewController()
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
        navigationbar.swicher = self
        
        navigationbarItem = NSSplitViewItem(sidebarWithViewController: navigationbar)
        navigationbarItem?.minimumThickness = 20
        navigationbarItem?.maximumThickness = 30
    }
    
    private func setupHierarchy() {
        addSplitViewItem(navigationbarItem!)
        addSplitViewItem(NSSplitViewItem(viewController: contentView))
    }
    
}

extension ProjectContentViewController: ProjectContentProtocol {
    
    func switchContent(_ viewController: NSViewController) {
        
        if let contentView = splitViewItems.last {
            removeSplitViewItem(contentView)
            addSplitViewItem(NSSplitViewItem(viewController: viewController))
        }
    }

}
