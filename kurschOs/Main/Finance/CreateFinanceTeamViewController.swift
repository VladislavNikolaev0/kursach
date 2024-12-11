//
//  CreateFinanceTeamViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class CreateFinanceTeamViewController: NSViewController {
    
    var finance: FinanceModule?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var teamNameLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Название команды")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var teamNameTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Название"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var teamTypeLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип команды")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var teamTypeTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Тип"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var createButton: NSButton = {
        let button = NSButton()
        button.title = "Создать"
        button.target = self
        button.action = #selector(createButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.alignment = .left
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        view = NSView(frame: NSRect(
            x: 0,
            y: 0,
            width: 400,
            height: 1200
        ))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(teamNameLable)
        commonStack.addArrangedSubview(teamNameTextField)
        commonStack.addArrangedSubview(teamTypeLable)
        commonStack.addArrangedSubview(teamTypeTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            commonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            createButton.topAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: 20),
            createButton.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 40),
            createButton.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -40),
        ])
    }
    
    @objc
    private func createButtonTapped() {
        
        if !teamNameTextField.stringValue.isEmpty &&
            !teamTypeTextField.stringValue.isEmpty {
            
            guard let finance else { return }
            
            TeamDataManager.shared.createTeamByFinance(
                teamName: teamNameTextField.stringValue,
                teamType: teamTypeTextField.stringValue,
                finance: finance
            )
            
            delegate?.modalDismiss()
            
            dismiss(self)
        }
    }
}
