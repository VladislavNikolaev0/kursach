//
//  CreateResearcherViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class CreateResearcherViewController: NSViewController {
    
    var team: Team?
    
    weak var delegate: ModalDismissProtocol?
    
    private lazy var firstNameLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Имя исследователя")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var firstNameTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Имя"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var lastNameLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Фамилия исследователя")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var lastNameTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Фамилия"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var birthDateLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата рождения")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var birthDateTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.98"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var positionLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Позиция в команде")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var positionTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Позиция"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var driverLecenceLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Права категории")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var driverLecenceTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "В"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var numberLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Серия и номер")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var numberTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "1234 567890"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var issuedByLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Кем выдан")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var issuedByTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "кем выдан"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var issuedDateLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата выдачи")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var issuedDateTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.12"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var allergiesLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Аллергии")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var allergiesTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "Аллергии"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var chronicDeseasesLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Хронические заболевания")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var chronicDeseasesTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "хранические заболевания"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var heightLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Рост (см)")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var heightTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "175"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var weightLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Вес (кг)")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var weightTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "60.5"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var medecineCheckupLabel: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "Дата последнего обследования")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var medecineCheckupTextField: NSTextField = {
        let field = NSTextField()
        field.placeholderString = "12.12.12"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var createButton: NSButton = {
        let button = NSButton()
        button.title = "Добавить"
        button.target = self
        button.action = #selector(createButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var personStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var passportStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var commonStack: NSStackView = {
        let stack = NSStackView()
        stack.orientation = .horizontal
        stack.distribution = .equalCentering
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
        view = NSView(frame: NSRect(
            x: 0,
            y: 0,
            width: 500,
            height: 600
        ))
    }
    
    private func setupHierarchy() {
        view.addSubview(commonStack)
        view.addSubview(createButton)
        commonStack.addArrangedSubview(personStack)
        commonStack.addArrangedSubview(passportStack)
        personStack.addArrangedSubview(firstNameLabel)
        personStack.addArrangedSubview(firstNameTextField)
        personStack.addArrangedSubview(lastNameLabel)
        personStack.addArrangedSubview(lastNameTextField)
        personStack.addArrangedSubview(birthDateLabel)
        personStack.addArrangedSubview(birthDateTextField)
        personStack.addArrangedSubview(positionLabel)
        personStack.addArrangedSubview(positionTextField)
        personStack.addArrangedSubview(driverLecenceLabel)
        personStack.addArrangedSubview(driverLecenceTextField)
        passportStack.addArrangedSubview(numberLabel)
        passportStack.addArrangedSubview(numberTextField)
        passportStack.addArrangedSubview(issuedByLabel)
        passportStack.addArrangedSubview(issuedByTextField)
        passportStack.addArrangedSubview(issuedDateLabel)
        passportStack.addArrangedSubview(issuedDateTextField)
        passportStack.addArrangedSubview(allergiesLabel)
        passportStack.addArrangedSubview(allergiesTextField)
        passportStack.addArrangedSubview(chronicDeseasesLabel)
        passportStack.addArrangedSubview(chronicDeseasesTextField)
        passportStack.addArrangedSubview(heightLabel)
        passportStack.addArrangedSubview(heightTextField)
        passportStack.addArrangedSubview(weightLabel)
        passportStack.addArrangedSubview(weightTextField)
        passportStack.addArrangedSubview(medecineCheckupLabel)
        passportStack.addArrangedSubview(medecineCheckupTextField)
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
            
            personStack.topAnchor.constraint(equalTo: commonStack.topAnchor),
            personStack.leadingAnchor.constraint(equalTo: commonStack.leadingAnchor),
            personStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor),
            
            passportStack.topAnchor.constraint(equalTo: commonStack.topAnchor),
            passportStack.trailingAnchor.constraint(equalTo: commonStack.trailingAnchor),
            passportStack.bottomAnchor.constraint(equalTo: commonStack.bottomAnchor),
        ])
    }
    
    @objc
    private func createButtonTapped() {
        if !firstNameTextField.stringValue.isEmpty &&
            !lastNameTextField.stringValue.isEmpty &&
            !birthDateTextField.stringValue.isEmpty &&
            !positionTextField.stringValue.isEmpty &&
            !driverLecenceTextField.stringValue.isEmpty &&
            !numberTextField.stringValue.isEmpty &&
            !issuedByTextField.stringValue.isEmpty &&
            !issuedDateTextField.stringValue.isEmpty &&
            !allergiesTextField.stringValue.isEmpty &&
            !chronicDeseasesTextField.stringValue.isEmpty &&
            !heightTextField.stringValue.isEmpty &&
            !weightTextField.stringValue.isEmpty &&
            !medecineCheckupTextField.stringValue.isEmpty {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yy"
            
            if let birthDate = dateFormatter.date(from: birthDateTextField.stringValue) {
                
                if let checkupDate = dateFormatter.date(from: medecineCheckupTextField.stringValue) {
                    
                    if let issuedDate = dateFormatter.date(from: issuedDateTextField.stringValue) {
                        
                        guard let team else { return }

                        let researcher = ResearcherDataManger.shared.createResearcher(
                            firstName: firstNameTextField.stringValue,
                            lastName: lastNameTextField.stringValue,
                            birthDate: birthDate,
                            driverLecence: driverLecenceTextField.stringValue,
                            position: positionTextField.stringValue,
                            team: team
                        )
           
                        let passport = PassportDataManger.shared.createPassowrdByReseacher(
                            number: numberTextField.stringValue,
                            issuedBy: issuedByTextField.stringValue,
                            issuedDate: issuedDate,
                            reseacher: researcher
                        )
                 
                        let card = MedecineCardDataManager.shared.createMedCard(
                            allergies: allergiesTextField.stringValue,
                            chronicDeseases: chronicDeseasesTextField.stringValue,
                            heightPerson: Int(heightTextField.stringValue)!,
                            weightPerson: Double(weightTextField.stringValue)!,
                            medecineCheckup: checkupDate
                        )
                 
                        ResearcherDataManger.shared.setPassportAndCard(
                            passport: passport,
                            card: card,
                            team: team,
                            firstName: firstNameTextField.stringValue,
                            lastName: lastNameTextField.stringValue
                        )
   
                        MedecineCardDataManager.shared.setResearcher(
                            researcher: researcher,
                            allergies: allergiesTextField.stringValue,
                            chronicDeseases: chronicDeseasesTextField.stringValue,
                            heightPerson: Int32(heightTextField.stringValue)!
                        )
         
                        delegate?.modalDismiss()
               
                        dismiss(self)
                    }
                }
            }
        }
    }
}
