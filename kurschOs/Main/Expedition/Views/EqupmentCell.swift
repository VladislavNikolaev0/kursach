//
//  EqupmentCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 05.12.2024.
//

import Cocoa

final class EqupmentCell: NSView {
    
    private lazy var name: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Название: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var count: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Количество: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var weight: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Вес: ")
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
        stack.distribution = .fill
        stack.alignment = .left
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var dopInfoStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.distribution = .fill
        stack.alignment = .right
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(name: String, count: String, weight: String) {
        super.init(frame: .zero)
        
        self.name.stringValue += name
        self.count.stringValue += count
        self.weight.stringValue += weight
        
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
        self.layer?.borderColor = NSColor.green.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupHierarchy() {
        addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(dopInfoStack)
        infoStack.addArrangedSubview(name)
        infoStack.addArrangedSubview(count)
        dopInfoStack.addArrangedSubview(weight)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            commonStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoStack.topAnchor.constraint(equalTo: commonStack.topAnchor, constant: 10),
            infoStack.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 10),
            infoStack.heightAnchor.constraint(equalToConstant: 50),

            dopInfoStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dopInfoStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dopInfoStack.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
