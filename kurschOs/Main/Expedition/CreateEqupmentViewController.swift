//
//  CreateEqupmentViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class CreateEqupmentViewController: NSViewController {
    
    var expedition: Expedition?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var nameLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Название снаряжения")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var nameTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Название"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var countLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Количество")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var countTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "3"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var weightLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Вес (кг)")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var weightTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "3.0"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var createButton: NSButton = {
        let button = NSButton()
        button.title = "Добавить"
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
            height: 600
        ))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(nameLable)
        commonStack.addArrangedSubview(nameTextField)
        commonStack.addArrangedSubview(countLable)
        commonStack.addArrangedSubview(countTextField)
        commonStack.addArrangedSubview(weightLable)
        commonStack.addArrangedSubview(weightTextField)
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
        
        if !nameTextField.stringValue.isEmpty &&
            !countTextField.stringValue.isEmpty &&
            !weightTextField.stringValue.isEmpty {
            
            guard let expedition else { return }
            
            EqupmentDataManager.shared.createEqupment(
                name: nameTextField.stringValue,
                conunt: Int(countTextField.stringValue)!,
                weight: Double(weightTextField.stringValue)!,
                expedition: expedition
            )
            
            delegate?.modalDismiss()
            
            dismiss(self)
        }
    }
}
