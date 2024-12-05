//
//  AnaliticCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

protocol AnaliticCellDelegate: AnyObject {
    func dedSelectCell(_ cell: AnaliticCell)
}

final class AnaliticCell: NSView {
    
    weak var deleaget: AnaliticCellDelegate?
    
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
        let field = NSTextField(wrappingLabelWithString: "Тип анализа: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var goal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основная цель: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainGoal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
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
    
    init(startDate: String, endDate: String, type: String, mainGoal: String) {
        super.init(frame: .zero)
        
        self.startDate.stringValue += startDate
        self.endDate.stringValue += endDate
        self.type.stringValue += type
        self.mainGoal.stringValue = mainGoal
        
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
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(cellTapped))
        
        self.addGestureRecognizer(gesture)
    }
    
    private func setupHierarchy() {
        addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(dateStack)
        infoStack.addArrangedSubview(type)
        infoStack.addArrangedSubview(goal)
        infoStack.addArrangedSubview(mainGoal)
        dateStack.addArrangedSubview(startDate)
        dateStack.addArrangedSubview(endDate)
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

            dateStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dateStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dateStack.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc
    private func cellTapped() {
        deleaget?.dedSelectCell(self)
    }
}
