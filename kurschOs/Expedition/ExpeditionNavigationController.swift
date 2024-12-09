//
//  ExpeditionNavigationController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class ExpeditionNavigationController: NSViewController {
    
    private var expedition: Expedition? = MainDataManager.shared.expedtion
    
    private lazy var editButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "pencil", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemBlue
        button.target = self
        button.action = #selector(editButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var deleteButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "trash", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemRed
        button.target = self
        button.action = #selector(deleteButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var expeditonName: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: expedition!.expeditionName!)
        field.font = NSFont.systemFont(ofSize: 20, weight: .heavy)
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(expeditonName)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            expeditonName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            expeditonName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -5),
            editButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            backButton.trailingAnchor.constraint(equalTo: editButton.leadingAnchor, constant: -5),
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
        let vc = ProjectSpitVeiw()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}
