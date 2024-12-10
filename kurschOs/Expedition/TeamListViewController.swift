//
//  TeamListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class TeamListViewController: NSViewController {
    
//    private lazy var testTeam = TeamCell(expeditionName: "Down", type: "geoeg")
    
    private var teams: [Team] = []
    
    private lazy var addTeamButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addTeamButtonTapped)
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
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
        //view.addSubview(testTeam)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addTeamButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            addTeamButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
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
        
        guard let expedtion = MainDataManager.shared.expedtion else { return }
        
        teams = TeamDataManager.shared.fetchAllTeamsByExpetion(expedition: expedtion)
        
        if !teams.isEmpty {
            
            var newTeamCell = TeamCell(
                expeditionName: teams[0].teamName!,
                type: teams[0].teamType!
            )
            
            newTeamCell.deleaget = self
            //newTeamCell.team = teams[0]
            
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
                    
                    newTeamCell.deleaget = self
                    //newTeamCell.team = teams[i]
                    
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
        let vc = CreateTeamViewController()

        guard let expedition = MainDataManager.shared.expedtion else { return }

        vc.expedition = expedition
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension TeamListViewController: TeamCellDelegate {
    
    func dedSelectCell(_ cell: TeamCell) {
        let vc = ChosenTeamViewController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension TeamListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchTeams()
    }
}
