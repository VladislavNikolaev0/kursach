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
        testProject.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            testProject.topAnchor.constraint(equalTo: view.topAnchor),
            testProject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            testProject.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            testProject.heightAnchor.constraint(equalToConstant: 145),
        ])
    }
}

extension MainOfficeViewController: ProjectCellViewDelegate {
    
    func didSelectCell(_ cell: ProjectCellView) {
        let vc = ProjectSpitVeiw()
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
    
}

