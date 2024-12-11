//
//  ProjectListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class EProjectListViewController: NSViewController {
    
    private var eprojects: [EProject] = []
    
    private lazy var backButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "arrow.uturn.backward", accessibilityDescription: nil)
        button.bezelColor = NSColor.orange
        button.target = self
        button.action = #selector(backButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoView: NSView = {
        let view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoUser: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Добро пожаловать, ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var emailLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var addProjectButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addProjectButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var exitButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "door.left.hand.open", accessibilityDescription: nil)
        button.bezelColor = .systemRed
        button.target = self
        button.action = #selector(exitButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalSrcollView: NSScrollView = {
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

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
        fetchPojects()
    }
    
    private func configure() {
        view = NSView(frame: NSRect(
            x: 0,
            y: 0,
            width: 1200,
            height: 600))
        
        guard let user = MainDataManager.shared.user else { return }
        
        infoUser.stringValue += user.fistName! + " " + user.lastName!
        emailLable.stringValue = user.email!
    }
    
    private func setupHierarchy() {
        view.addSubview(infoView)
        view.addSubview(verticalSrcollView)
        infoView.addSubview(backButton)
        infoView.addSubview(addProjectButton)
        infoView.addSubview(exitButton)
        infoView.addSubview(infoUser)
        infoView.addSubview(emailLable)
        verticalSrcollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.heightAnchor.constraint(equalToConstant: 30),
            
            verticalSrcollView.topAnchor.constraint(equalTo: infoView.bottomAnchor),
            verticalSrcollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            verticalSrcollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            verticalSrcollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalSrcollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: verticalSrcollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: verticalSrcollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: verticalSrcollView.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 5),
            
            addProjectButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5),
            addProjectButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5),
            
            infoUser.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -5),
            infoUser.leadingAnchor.constraint(equalTo: addProjectButton.trailingAnchor, constant: 10),
            
            exitButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5),
            exitButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -5),
            
            emailLable.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -5),
            emailLable.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant: -10),
        ])
    }
    
    func fetchPojects() {
        
        eprojects = EProjectDataManager.shared.fetchAllProjects()
        let projects = ProjectDataManager.shared.fetchAllProjectsByUser(user: MainDataManager.shared.user!)
        
        if !eprojects.isEmpty {
            
            var newCellProject = ProjectCellView(
                mainGoalText: eprojects[0].mainGoal!,
                startDateText: "\(eprojects[0].startDate!)",
                endDateText: "\(eprojects[0].endDate!)"
            )
            
            newCellProject.delegate = self
            newCellProject.eproject = eprojects[0]
            newCellProject.project = projects[0]
            
            contentView.addSubview(newCellProject)
            
            NSLayoutConstraint.activate([
                
                newCellProject.topAnchor.constraint(equalTo: contentView.topAnchor),
                newCellProject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newCellProject.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newCellProject.heightAnchor.constraint(equalToConstant: 85),
            ])
            
            if eprojects.count > 1 {
                
                for i in 1..<eprojects.count {
                    
                    let cellProject = ProjectCellView(
                        mainGoalText: eprojects[i].mainGoal!,
                        startDateText: "\(eprojects[i].startDate!)",
                        endDateText: "\(eprojects[i].endDate!)"
                    )
                    
                    cellProject.delegate = self
                    cellProject.eproject = eprojects[i]
                    cellProject.project = projects[i]
                    
                    contentView.addSubview(cellProject)
                    
                    NSLayoutConstraint.activate([
                        cellProject.topAnchor.constraint(equalTo: newCellProject.bottomAnchor),
                        cellProject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellProject.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellProject.heightAnchor.constraint(equalToConstant: 85),
                    ])
                    
                    newCellProject = cellProject
                }
            }
        }
    }
    
    @objc
    private func backButtonTapped() {
        let vc = ChoiseInProjectContoller()
        vc.setIsLogged(isLogged: true)
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
    
    @objc
    private func addProjectButtonTapped() {
        let vc = CreateEProjectViewController()
        
        guard let user = MainDataManager.shared.user else { return }
        
        vc.setUser(user: user)
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
    
    @objc
    private func exitButtonTapped() {
        let vc = ChoiseInProjectContoller()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension EProjectListViewController: ProjectCellViewDelegate {
    
    func didSelectCell(_ cell: ProjectCellView) {
        let vc = EProjectSplitViewController()
        
        MainExpeditonDataManager.shared.project = cell.eproject
        MainDataManager.shared.project = cell.project
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension EProjectListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchPojects()
    }
}