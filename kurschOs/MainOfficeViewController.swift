//
//  ViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 24.11.2024.
//

import Cocoa

class MainOfficeViewController: NSViewController {
    
    private lazy var testProject = ProjectCellView(
        mainGoalText: "Try firs project",
        startDateText: "12.12.24",
        endDateText: "12.12.25",
        researcherText: "12",
        analysText: "2"
    )
    
    private lazy var backButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "arrow.uturn.backward", accessibilityDescription: nil)
        button.bezelColor = NSColor.orange
        button.target = self
        button.action = #selector(backButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = NSView(frame: NSRect(
            x: 0,
            y: 0,
            width: 1200,
            height: 600))
        
        setupUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(testProject)
        view.addSubview(backButton)
        testProject.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            testProject.topAnchor.constraint(equalTo: view.topAnchor),
            testProject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            testProject.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            testProject.heightAnchor.constraint(equalToConstant: 145),
            
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
        ])
    }
    
    @objc
    private func backButtonTapped() {
        let vc = ChoiseInProjectContoller()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension MainOfficeViewController: ProjectCellViewDelegate {
    
    func didSelectCell(_ cell: ProjectCellView) {
        let vc = ProjectSpitVeiw()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
    
}

