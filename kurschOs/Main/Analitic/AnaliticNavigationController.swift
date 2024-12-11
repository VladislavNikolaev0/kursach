//
//  AnaliticNavigationController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AnaliticNavigationController: NSViewController {
    
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
    
    private lazy var backButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "arrow.uturn.backward", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemOrange
        button.target = self
        button.action = #selector(backButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var analiticTypeLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .left
        field.font = NSFont.systemFont(ofSize: 20, weight: .heavy)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
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
        
        guard let analitic = MainDataManager.shared.analitic else { return }
        
        analiticTypeLable.stringValue = analitic.analiticType!
    }
    
    private func setupHierarchy() {
        view.addSubview(analiticTypeLable)
        view.addSubview(editButton)
        view.addSubview(deleteButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            analiticTypeLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            analiticTypeLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
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
    
    @objc func deleteButtonTapped() {
        
    }
    
    @objc func backButtonTapped() {
        let vc = ProjectSpitVeiw()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}
