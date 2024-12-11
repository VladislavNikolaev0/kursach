//
//  ETeamsListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class ETeamsListViewController: NSViewController {
    
    private var teams: [ETeam] = []
    
    private lazy var addTeamButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addTeamButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var backButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "arrow.uturn.backward", accessibilityDescription: nil)
        button.bezelColor = NSColor.orange
        button.target = self
        button.action = #selector(backButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        fetchTeams()
    }
    
    private func setupHierarchy() {
        view.addSubview(addTeamButton)
        view.addSubview(backButton)
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
        //view.addSubview(testTeam)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addTeamButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            addTeamButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addTeamButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchTeams() {
        
        guard let expedtion = MainExpeditonDataManager.shared.expedition else { return }
        
        teams = ETeamDataManager.shared.fetchAllTeamsByExpetion(expedition: expedtion)
        
        if !teams.isEmpty {
            
            var newTeamCell = TeamCell(
                expeditionName: teams[0].teamName!,
                type: teams[0].teamType!
            )
            
            newTeamCell.deleaget = self
            newTeamCell.eteam = teams[0]
            
            contentView.addSubview(newTeamCell)
            
            NSLayoutConstraint.activate([
                
                newTeamCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                newTeamCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newTeamCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newTeamCell.heightAnchor.constraint(equalToConstant: 100),
            ])
            
            if teams.count > 1 {
                
                for i in 1..<teams.count {
                    
                    let cellTeam = TeamCell(
                        expeditionName: teams[i].teamName!,
                        type: teams[i].teamType!
                    )
                    
                    cellTeam.deleaget = self
                    newTeamCell.eteam = teams[i]
                    
                    contentView.addSubview(cellTeam)
                    
                    NSLayoutConstraint.activate([
                        
                        cellTeam.topAnchor.constraint(equalTo: newTeamCell.bottomAnchor),
                        cellTeam.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellTeam.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellTeam.heightAnchor.constraint(equalToConstant: 100),
                    ])
                    
                    newTeamCell = cellTeam
                }
            }
        }
    }
    
    @objc
    private func addTeamButtonTapped() {
        let vc = CreateETeamViewController()

        guard let expedition = MainDataManager.shared.expedtion else { return }
        guard let eexpedition = MainExpeditonDataManager.shared.expedition else { return }

        vc.expedition = expedition
        vc.eexpedition = eexpedition
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
    
    @objc
    private func backButtonTapped() {
        let vc = EProjectSplitViewController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension ETeamsListViewController: TeamCellDelegate {
    
    func dedSelectCell(_ cell: TeamCell) {

    }
}

extension ETeamsListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchTeams()
    }
}
