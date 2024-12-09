//
//  ProjectCellView.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 24.11.2024.
//

import Cocoa

protocol ProjectCellViewDelegate: AnyObject {
    func didSelectCell(_ cell: ProjectCellView)
}

final class ProjectCellView: NSView {
    
    weak var delegate: ProjectCellViewDelegate?

    private lazy var mainGoal: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основная цель: ")
        field.alignment = .right
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDate: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата окончания: ")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
//    private lazy var numberResearchesTeam: NSTextField = {
//        let field = NSTextField(wrappingLabelWithString: "Team number: ")
//        field.alignment = .right
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
//    
//    private lazy var numberAnalystTeam: NSTextField = {
//        let field = NSTextField(wrappingLabelWithString: "Team number: ")
//        field.alignment = .right
//        field.translatesAutoresizingMaskIntoConstraints = false
//        return field
//    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer?.backgroundColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
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
        stack.distribution = .fillEqually
        stack.alignment = .left
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(mainGoalText: String, startDateText: String, endDateText: String) { //researcherText: String, analysText: String) {
        super.init(frame: .zero)
        
        self.mainGoal.stringValue += mainGoalText
        self.startDate.stringValue += startDateText
        self.endDate.stringValue += endDateText
//        self.numberResearchesTeam.stringValue += researcherText
//        self.numberAnalystTeam.stringValue += analysText
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setupHierarchy()
        setupConstraints()
        configure()
    }
    
    private func setupHierarchy() {
        addSubview(commonStack)
        commonStack.addArrangedSubview(infoStack)
        commonStack.addArrangedSubview(dateStack)
        infoStack.addArrangedSubview(mainGoal)
//        infoStack.addArrangedSubview(numberResearchesTeam)
//        infoStack.addArrangedSubview(numberAnalystTeam)
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
            infoStack.heightAnchor.constraint(equalToConstant: 50),
            
            dateStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: -10),
            dateStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -10),
            dateStack.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configure() {
        wantsLayer = true
        self.layer?.borderWidth = 2
        self.layer?.cornerRadius = 10
        self.layer?.borderColor = NSColor.white.cgColor
        
        let gesture = NSClickGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(gesture)
    }
    
    @objc
    private func cellTapped() {
        delegate?.didSelectCell(self)
    }
}
