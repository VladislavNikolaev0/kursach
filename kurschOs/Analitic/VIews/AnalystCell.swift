//
//  AnalystCell.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AnalystCell: NSTableCellView {
    
    private lazy var name: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var surname: NSTextField = {
        let field = NSTextField(wrappingLabelWithString: "")
        field.alignment = .left
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var personImage: NSImageView = {
        let image = NSImageView()
        image.image = NSImage(systemSymbolName: "person.fill", accessibilityDescription: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setName(_ name: String) {
        self.name.stringValue = name
    }
    
    public func setSurname(_ surname: String) {
        self.surname.stringValue = surname
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        addSubview(personImage)
        addSubview(name)
        addSubview(surname)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            personImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            personImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            name.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 10),
            
            surname.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5),
            surname.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 10),
        ])
    }
}
