//
//  ChosenProject.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ChosenProjectController: NSViewController {
    
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
    
    private let splitViewController = ProjectDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = NSView(frame: NSRect(
                                    x: 0,
                                    y: 0,
                                    width: 1100,
                                    height: 600)
                                    )
        
        setupUI()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(deleteButton)
        view.addSubview(editButton)
        view.addSubview(splitViewController.view)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -15),
            editButton.widthAnchor.constraint(equalToConstant: 40),
            editButton.heightAnchor.constraint(equalToConstant: 40),
            
            splitViewController.view.topAnchor.constraint(equalTo: editButton.bottomAnchor),
            splitViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splitViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splitViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc
    private func editButtonTapped() {
        
    }
    
    @objc
    private func deleteButtonTapped() {
        
    }
}
