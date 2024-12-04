//
//  AnaliticCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

class AnaliticCell: NSView {
    
    private lazy var startDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var type: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var goal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
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
    
    init(startDate: String, endDate: String, type: String, goal: String) {
        super.init(frame: .zero)
        
        self.startDate.stringValue += startDate
        self.endDate.stringValue += endDate
        self.type.stringValue += type
        self.goal.stringValue += goal
        
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
        
    }
    private func setupConstraints() {
        
    }
}
