//
//  FinanceCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

protocol FinanceCellDelegate: AnyObject {
    func dedSelectCell(_ cell: FinanceCell)
}

final class FinanceCell: NSView {
    
    weak var deleaget: FinanceCellDelegate?
    var finance: FinanceModule?
    
    private lazy var startDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата окончания: ")
        field.alignment = .right
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
    
    private lazy var dateStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 10
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
    
    init(startDate: String, endDate: String) {
        super.init(frame: .zero)
        
        self.startDate.stringValue += startDate
        self.endDate.stringValue += endDate
        
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
        infoStack.addArrangedSubview(startDate)
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
            infoStack.heightAnchor.constraint(equalToConstant: 30),

            dateStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dateStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dateStack.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc
    private func cellTapped() {
        deleaget?.dedSelectCell(self)
    }
}

