//
//  ProjectSpitVeiw.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

protocol ProjectSpitProtocol {
    
    func getControllerToChild(_ viewController: NSViewController)
}

final class ProjectSpitVeiw: NSSplitViewController {
    
    private let sidebar = ProjectSideBarController()
    private let rightContent = ProjectContentViewController()
    private var sidebarItem: NSSplitViewItem?
    private var rightContentItem: NSSplitViewItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private var switcher: ProjectContentProtocol?
    
    private func setupUI() {
        configure()
        setupHierarchy()
        
    }
    
    private func configure() {
        self.splitView.isVertical = true
        
        switcher = rightContent
        sidebar.swicher = self
        
        sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebar)
        sidebarItem?.minimumThickness = 250
        
        rightContentItem = NSSplitViewItem(viewController: rightContent)
        rightContentItem?.minimumThickness = 600
    }
    
    private func setupHierarchy() {
        addSplitViewItem(sidebarItem!)
        addSplitViewItem(rightContentItem!)
    }
}

extension ProjectSpitVeiw: ProjectSpitProtocol {
    
    func getControllerToChild(_ viewController: NSViewController) {
        switcher?.switchContent(viewController)
    }
}
