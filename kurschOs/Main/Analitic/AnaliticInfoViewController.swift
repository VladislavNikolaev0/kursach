//
//  AnaliticInfoViewControllers.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AnaliticInfoViewController: NSSplitViewController {
    
    private let teamController = AnaliticTeamListViewController()
    private let resutController = AnaliticResultsViewController()
    
    private var teamItem: NSSplitViewItem?
    private var resultItem: NSSplitViewItem?
    
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
        
        teamItem = NSSplitViewItem(sidebarWithViewController: teamController)
        resultItem = NSSplitViewItem(viewController: resutController)
        
        teamItem?.minimumThickness = 400
        teamItem?.maximumThickness = 450
        resultItem?.minimumThickness = 600
    }
    
    private func setupHierarchy() {
        addSplitViewItem(teamItem!)
        addSplitViewItem(resultItem!)
    }
}
