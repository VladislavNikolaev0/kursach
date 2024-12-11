//
//  FinanceInfoViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class FinanceInfoViewController: NSSplitViewController {
    
    private let teamController = FinanceTeamListViewController()
    private let resultController = FinanceResultsViewController()
    
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
        resultItem = NSSplitViewItem(viewController: resultController)
        
        teamItem?.minimumThickness = 400
        teamItem?.maximumThickness = 450
        resultItem?.minimumThickness = 600
    }
    
    private func setupHierarchy() {
        addSplitViewItem(teamItem!)
        addSplitViewItem(resultItem!)
    }
}
