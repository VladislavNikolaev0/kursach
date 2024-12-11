//
//  CreateTransportViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class CreateTransportViewController: NSViewController {
    
    var expedition: Expedition?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var transportTypeLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип транспорта")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var transportTypeTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Тип"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var modelLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Модель")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var modelTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Модель"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var registerNumberLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Регистрационный номер")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var registerNumberTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Регистрационный номер"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var lecenceCategoryLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Категория прав для вождения")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var lecenceCategoryTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Категория"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passengersLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Количество пассажиров")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passengersTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "3"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var capacityLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Грузоподъемность (кг)")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var capacityTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "300.0"
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
            height: 1500
        ))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(transportTypeLable)
        commonStack.addArrangedSubview(transportTypeTextField)
        commonStack.addArrangedSubview(modelLable)
        commonStack.addArrangedSubview(modelTextField)
        commonStack.addArrangedSubview(registerNumberLable)
        commonStack.addArrangedSubview(registerNumberTextField)
        commonStack.addArrangedSubview(lecenceCategoryLable)
        commonStack.addArrangedSubview(lecenceCategoryTextField)
        commonStack.addArrangedSubview(passengersLable)
        commonStack.addArrangedSubview(passengersTextField)
        commonStack.addArrangedSubview(capacityLable)
        commonStack.addArrangedSubview(capacityTextField)
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
        
        if !transportTypeTextField.stringValue.isEmpty &&
            !modelTextField.stringValue.isEmpty &&
            !registerNumberTextField.stringValue.isEmpty &&
            !lecenceCategoryTextField.stringValue.isEmpty &&
            !passengersTextField.stringValue.isEmpty &&
            !capacityTextField.stringValue.isEmpty {
         
            guard let expedition else { return }
            
            TransportDataManager.shared.createTransport(
                transprotType: transportTypeTextField.stringValue,
                model: modelTextField.stringValue,
                registerNumber: registerNumberTextField.stringValue,
                lecenceCategory: lecenceCategoryTextField.stringValue,
                passengers: Int(passengersTextField.stringValue)!,
                capacity: Double(capacityTextField.stringValue)!,
                expedition: expedition
            )
            
            delegate?.modalDismiss()
            
            dismiss(self)
        }
    }
}
