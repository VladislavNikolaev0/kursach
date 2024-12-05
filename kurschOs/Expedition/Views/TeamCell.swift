//
//  TeamCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

protocol TeamCellDelegate: AnyObject {
    func dedSelectCell(_ cell: TeamCell)
}

final class TeamCell: NSView {
    
    weak var deleaget: TeamCellDelegate?
    
    private lazy var name: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Название: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private lazy var type: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Тип экспедиции: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var typeStack: NSStackView = {
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
    
    init(expeditionName: String, type: String) {
        super.init(frame: .zero)
        
        self.name.stringValue += expeditionName
        self.type.stringValue += type
        
        translatesAutoresizingMaskIntoConstraints = false
        
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
        self.layer?.borderColor = NSColor.white.cgColor
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(cellTapped))
        
        self.addGestureRecognizer(gesture)
    }
    
    private func setupHierarchy() {
        addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(typeStack)
        infoStack.addArrangedSubview(name)
        typeStack.addArrangedSubview(type)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: topAnchor),
            commonStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            commonStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            commonStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoStack.topAnchor.constraint(equalTo: commonStack.topAnchor, constant: 10),
            infoStack.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 10),
            infoStack.heightAnchor.constraint(equalToConstant: 30),

            typeStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            typeStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            typeStack.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc
    private func cellTapped() {
        deleaget?.dedSelectCell(self)
    }
}
