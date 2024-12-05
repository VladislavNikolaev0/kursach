//
//  ExpeditionResultsController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class ExpeditionResultsController: NSViewController {
    
    private lazy var startDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала: 12.12.12")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата окончания: 12.21.12")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var type: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип экспедиции: dfsjsert")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var results: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Результаты: sdalfajsdflajsdflksajf;lasjdf;laf")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        field.lineBreakStrategy = .standard
        return field
    }()
    
    private lazy var mainGoal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основаная цель: sdafsdfaadsfas")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        field.lineBreakStrategy = .standard
        return field
    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var dateStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.distribution = .fill
        stack.alignment = .right
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var infoStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 10
        stack.alignment = .left
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

    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(dateStack)
        dateStack.addArrangedSubview(type)
        infoStack.addArrangedSubview(results)
        infoStack.addArrangedSubview(mainGoal)
        dateStack.addArrangedSubview(startDate)
        dateStack.addArrangedSubview(endDate)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: view.topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoStack.topAnchor.constraint(equalTo: commonStack.topAnchor, constant: 10),
            infoStack.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 10),
            infoStack.heightAnchor.constraint(equalToConstant: 120),

            dateStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dateStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dateStack.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
