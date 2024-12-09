//
//  CreateProjectViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 08.12.2024.
//

import Cocoa

final class CreateProjectViewController: NSViewController {
    
    private var user: User?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var startDateLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата начала")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startDateTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.12"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDateLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Предпологаемая дата окончания")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var endDateTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.12"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainGoalLable: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Основная цель")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var mainGoalTextField: NSTextField = {
        let field = NSTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var createButton: NSButton = {
        let button = NSButton()
        button.title = "Создать"
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
    
    public func setUser(user: User) {
        self.user = user
    }
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configure() {
        view = NSView(frame: NSRect(x: view.bounds.width / 2 - 100, y: view.bounds.height / 2 - 150, width: 400, height: 700))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(startDateLabel)
        commonStack.addArrangedSubview(startDateTextField)
        commonStack.addArrangedSubview(endDateLabel)
        commonStack.addArrangedSubview(endDateTextField)
        commonStack.addArrangedSubview(mainGoalLable)
        commonStack.addArrangedSubview(mainGoalTextField)
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
        
        if !startDateTextField.stringValue.isEmpty &&
            !endDateTextField.stringValue.isEmpty &&
            !mainGoalTextField.stringValue.isEmpty {
            
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MM.yy"
            
            if let startDate = dateFormater.date(from: startDateTextField.stringValue) {
                
                if let endDate = dateFormater.date(from: endDateTextField.stringValue) {
                    
                    guard let user = user else { return }
                    
                    ProjectDataManager.shared.createProject(
                        startDate: startDate,
                        endDate: endDate,
                        mainGoal: mainGoalTextField.stringValue,
                        user: user)
                    
                    delegate?.modalDismiss()
                    
                    dismiss(self)
                }
                
            } else {
                print("Not write data")
            }
        }
    }
}
