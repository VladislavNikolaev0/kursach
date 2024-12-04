//
//  ExpeditionCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ExpeditionCell: NSView {
    
    private lazy var name: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Название: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата окончания: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var type: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип экспедиции: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var goal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основная цель: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.alignment = .right
        stack.distribution = .equalSpacing
        return stack
    }()
    
    init(expeditionName: String, startDate: String, endDate: String, type: String, mainGoal: String) {
        super.init(frame: .zero)
        
        self.name.stringValue += expeditionName
        self.startDate.stringValue += startDate
        self.endDate.stringValue += endDate
        self.type.stringValue += type
        self.goal.stringValue += mainGoal
        
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
        
    }
    
    private func setupHierarchy() {
        addSubview(mainStack)
        
        mainStack.addArrangedSubview(name)
        mainStack.addArrangedSubview(startDate)
        mainStack.addArrangedSubview(endDate)
        mainStack.addArrangedSubview(type)
        
        addSubview(goal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            goal.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 5),
            goal.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor),
            
        ])
    }
}
