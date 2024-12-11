//
//  CreateAnaliticViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 09.12.2024.
//

import Cocoa

final class CreateAnaliticViewController: NSViewController {
    
    var project: Project?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var analiticTypeLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип аналитического блока")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var analiticTypeTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Тип"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDateLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDateTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.12"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainGoalLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основная цель")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainGoalTextField: NSTextField = {
        let field = NSTextField()
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
            height: 800
        ))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(analiticTypeLable)
        commonStack.addArrangedSubview(analiticTypeTextField)
        commonStack.addArrangedSubview(startDateLabel)
        commonStack.addArrangedSubview(startDateTextField)
        commonStack.addArrangedSubview(mainGoalLable)
        commonStack.addArrangedSubview(mainGoalTextField)
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
        
        if !analiticTypeTextField.stringValue.isEmpty &&
            !startDateTextField.stringValue.isEmpty &&
            !mainGoalTextField.stringValue.isEmpty {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            if let startDate = dateFormatter.date(from: startDateTextField.stringValue) {
                
                guard let project = project else { return }
                
                AnaliticDataManager.shared.createAnalitic(
                    startDate: startDate,
                    mainGoal: mainGoalTextField.stringValue,
                    analiticType: analiticTypeTextField.stringValue,
                    project: project
                )
                
                delegate?.modalDismiss()
                
                dismiss(self)
            }
        }
    }
}
