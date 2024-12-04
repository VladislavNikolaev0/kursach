//
//  Untitled.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 25.11.2024.
//

import Cocoa

final class ChoiseInProjectContoller: NSViewController {
    
    private lazy var mainButton: NSButton = {
        let button = NSButton()
        button.title = "Главный офис"
        button.isBordered = true
        button.target = self
        button.action = #selector(mainButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var researchButton: NSButton = {
        let button = NSButton()
        button.title = "Исследовательский отдел"
        button.isBordered = true
        button.target = self
        button.action = #selector(researchButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var analystButton: NSButton = {
        let button = NSButton()
        button.title = "Аналитический отдел"
        button.isBordered = true
        button.target = self
        button.action = #selector(analystButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var financeButton: NSButton = {
        let button = NSButton()
        button.title = "Финансовый отдел"
        button.isBordered = true
        button.target = self
        button.action = #selector(financeButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choise"
        self.view = NSView(frame: NSRect(
            x: 0,
            y: 0,
            width: 800,
            height: 400))
        
        setupUI()
        
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(mainButton)
        view.addSubview(researchButton)
        view.addSubview(analystButton)
        view.addSubview(financeButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            mainButton.widthAnchor.constraint(equalToConstant: 150),
            
            researchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            researchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            analystButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            analystButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            financeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            financeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
        ])
    }
    
    @objc
    private func mainButtonTapped() {
        let vc = MainOfficeViewController()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
    
    @objc
    private func researchButtonTapped() {
        
    }
    
    @objc
    private func analystButtonTapped() {
        
    }
    
    @objc
    private func financeButtonTapped() {
        
    }
}
