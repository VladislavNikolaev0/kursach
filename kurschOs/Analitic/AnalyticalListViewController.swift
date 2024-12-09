//
//  AnalyticalListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class AnalyticalListViewController: NSViewController {
    
    private var analitics: [Analitical] = []
    
    private lazy var addAnaliticButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addAnaliticButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var verticalScrollView: NSScrollView = {
        let scroll = NSScrollView()
        scroll.hasVerticalScroller = true
        scroll.hasHorizontalScroller = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: NSView = {
        let view = NSView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        fetchAnalitics()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalScrollView)
        view.addSubview(addAnaliticButton)
        verticalScrollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addAnaliticButton.topAnchor.constraint(equalTo: view.topAnchor),
            addAnaliticButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addAnaliticButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchAnalitics() {
        
        guard let project = MainDataManager.shared.project else { return }
        
        analitics = AnaliticDataManager.shared.fetchAllAnaliticByProject(project: project)
        
        if !analitics.isEmpty {
            
            var newCellAnalitic = AnaliticCell(
                startDate: "\(analitics[0].startDate!)",
                type: analitics[0].analiticType!,
                mainGoal: analitics[0].mainGoal!
            )
            
            newCellAnalitic.deleaget = self
            newCellAnalitic.analitic = analitics[0]
            
            contentView.addSubview(newCellAnalitic)
            
            NSLayoutConstraint.activate([
                
                newCellAnalitic.topAnchor.constraint(equalTo: contentView.topAnchor),
                newCellAnalitic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newCellAnalitic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newCellAnalitic.heightAnchor.constraint(equalToConstant: 105),
            ])
            
            if analitics.count > 1 {
                
                for i in 1..<analitics.count {
                    
                    let cellAnalitic = AnaliticCell(
                        startDate: "\(analitics[i].startDate!)",
                        type: analitics[i].analiticType!,
                        mainGoal: analitics[i].mainGoal!
                    )
                    
                    cellAnalitic.deleaget = self
                    cellAnalitic.analitic = analitics[i]
                    
                    contentView.addSubview(cellAnalitic)
                    
                    NSLayoutConstraint.activate([
                        
                        cellAnalitic.topAnchor.constraint(equalTo: newCellAnalitic.bottomAnchor),
                        cellAnalitic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellAnalitic.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellAnalitic.heightAnchor.constraint(equalToConstant: 105),
                    ])
                    
                    newCellAnalitic = cellAnalitic
                }
            }
        }
    }
    
    @objc
    private func addAnaliticButtonTapped() {
        let vc = CreateAnaliticViewController()

        guard let project = MainDataManager.shared.project else { return }

        vc.project = project
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension AnalyticalListViewController: AnaliticCellDelegate {
    
    func dedSelectCell(_ cell: AnaliticCell) {
        
    }
}

extension AnalyticalListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchAnalitics()
    }
}
