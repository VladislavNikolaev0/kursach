//
//  AuthorisationViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 08.12.2024.
//

import Cocoa

final class AuthorisationViewController: NSViewController {
    
    weak var delegate: GetUserProtocol?
    
    private lazy var loginLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Логин")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var loginField: NSTextField = {
        let field = NSTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passwordLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Пароль")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var passwordField: NSSecureTextField = {
        let field = NSSecureTextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var loginButton: NSButton = {
        let button = NSButton()
        button.title = "Вход"
        button.target = self
        button.action = #selector(loginButtonTapped)
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
    
    private func setupUI() {
        configure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func configure() {
        view = NSView(frame: NSRect(x: view.bounds.width / 2 - 100, y: view.bounds.height / 2 - 150, width: 200, height: 500))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(loginButton)
        commonStack.addArrangedSubview(loginLabel)
        commonStack.addArrangedSubview(loginField)
        commonStack.addArrangedSubview(passwordLabel)
        commonStack.addArrangedSubview(passwordField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            commonStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            commonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            commonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            commonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            loginButton.topAnchor.constraint(equalTo: commonStack.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor, constant: -40),
            
        ])
    }
    
    @objc
    private func loginButtonTapped() {
        
        if !loginField.stringValue.isEmpty && !passwordField.stringValue.isEmpty {
            
            let user = UserDataManager.shared.fetchUser(login: loginField.stringValue)
            
            guard let user = user else { return }
            
            if user.password == passwordField.stringValue {
                
                delegate?.broadcastUser(user: user)
                MainDataManager.shared.user = user
                dismiss(self)
                
            } else {
                print("sdfs")
            }
        }
    }
}
