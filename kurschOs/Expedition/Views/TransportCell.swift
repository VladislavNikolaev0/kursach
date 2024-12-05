//
//  TransportCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class TransportCell: NSView {
    
    private lazy var transportType: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип транспорта: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var model: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Модель: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var registerNuber: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Регистрационный номер: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var licenceCategory: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Категория прав для вождения: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passengers: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Количество пассажиров: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var capacity: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Грузоподъемность: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var infoStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .left
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var dopInfoStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .right
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(transportType: String, model: String, registerNumber: String, licenceCategory: String, passengers: String, capacity: String) {
        super.init(frame: .zero)
        
        self.transportType.stringValue += transportType
        self.model.stringValue += model
        self.registerNuber.stringValue += registerNumber
        self.licenceCategory.stringValue += licenceCategory
        self.passengers.stringValue += passengers
        self.capacity.stringValue += capacity
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configure() {
        wantsLayer = true
        self.layer?.borderWidth = 2
        self.layer?.cornerRadius = 10
        self.layer?.borderColor = NSColor.yellow.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(dopInfoStack)
        infoStack.addArrangedSubview(transportType)
        infoStack.addArrangedSubview(model)
        infoStack.addArrangedSubview(registerNuber)
        dopInfoStack.addArrangedSubview(licenceCategory)
        dopInfoStack.addArrangedSubview(passengers)
        dopInfoStack.addArrangedSubview(capacity)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            commonStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoStack.topAnchor.constraint(equalTo: commonStack.topAnchor, constant: 10),
            infoStack.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 10),
            infoStack.heightAnchor.constraint(equalToConstant: 120),

            dopInfoStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dopInfoStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dopInfoStack.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
