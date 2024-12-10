//
//  AnaliticTeamListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AnaliticTeamListViewController: NSViewController {
    
    private var teams: [Team] = []
    
    private lazy var addTeamButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = .systemGreen
        button.target = self
        button.action = #selector(addTeamButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalScrollView: NSScrollView = {
        let scroll = NSScrollView()
        scroll.backgroundColor = .clear
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
        print(verticalScrollView.backgroundColor)
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
        
        guard let analitic = MainDataManager.shared.analitic else { return }
        
        teams = TeamDataManager.shared.fetchAllTeamsByAnalitic(analitic: analitic)
        
        if !teams.isEmpty {
            
            var newAnaliticteamCell = AnaliticTeamCell(
                teamName: teams[0].teamName!,
                type: teams[0].teamType!
            )
            
            newAnaliticteamCell.deleaget = self
            
            contentView.addSubview(newAnaliticteamCell)
            
            NSLayoutConstraint.activate([
                
                newAnaliticteamCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                newAnaliticteamCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newAnaliticteamCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newAnaliticteamCell.heightAnchor.constraint(equalToConstant: 100),
            ])
            
            if teams.count > 1 {
                
                for i in 1..<teams.count {
                    
                    let cellTeam = AnaliticTeamCell(
                        teamName: teams[i].teamName!,
                        type: teams[i].teamType!
                    )
                    
                    cellTeam.deleaget = self
                    //newTeamCell.team = teams[i]
                    
                    contentView.addSubview(cellTeam)
                    
                    NSLayoutConstraint.activate([
                        
                        cellTeam.topAnchor.constraint(equalTo: newAnaliticteamCell.bottomAnchor),
                        cellTeam.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellTeam.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellTeam.heightAnchor.constraint(equalToConstant: 100),
                    ])
                    
                    newAnaliticteamCell = cellTeam
                }
            }
        }
    }
    
    
    @objc
    private func addTeamButtonTapped() {
        let vc = CreateAnalitcTeamViewController()
        
        guard let analitic = MainDataManager.shared.analitic else { return }
        
        vc.analitic = analitic
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension AnaliticTeamListViewController: AnaliticTeamCellDelegate {
    
    func dedSelectCell(_ cell: AnaliticTeamCell) {
        
    }

}

extension AnaliticTeamListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchTeams()
    }
}
