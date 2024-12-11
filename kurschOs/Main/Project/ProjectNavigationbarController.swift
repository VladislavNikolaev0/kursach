//
//  ProjectNavigationbarController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class ProjectNavigationbarController: NSViewController {
    
    private lazy var editButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "pencil", accessibilityDescription: nil)
        button.target = self
        button.action = #selector(editButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "trash", accessibilityDescription: nil)
        button.target = self
        button.action = #selector(deleteButtonTapped)
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
    
    var swicher: ProjectContentProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configure() {
        view = NSView(frame: NSRect(x: 0, y: 0, width: 300, height: 50))
    }
    
    private func setupHierarchy() {
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
        ])
    }
    
    @objc
    private func editButtonTapped() {

    }
    
    @objc
    private func deleteButtonTapped() {
        
    }
    
    @objc
    private func backButtonTapped() {
        let vc = MainOfficeViewController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}
