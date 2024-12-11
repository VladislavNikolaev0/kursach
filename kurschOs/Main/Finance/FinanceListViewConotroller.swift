//
//  FinanceList.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class FinanceListViewController: NSViewController {
    
    private var finances: [FinanceModule] = []
    
    private lazy var addFinanceButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addFinanceButtonTapped)
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
        fetchFinances()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalScrollView)
        view.addSubview(addFinanceButton)
        verticalScrollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addFinanceButton.topAnchor.constraint(equalTo: view.topAnchor),
            addFinanceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addFinanceButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchFinances() {
        
        guard let project = MainDataManager.shared.project else { return }
        
        finances = FinanceDataManager.shared.fetchAllFinanceByProject(project: project)
        
        if !finances.isEmpty {
            
            var newCellFinance = FinanceCell(
                startDate: "\(finances[0].startDate!)",
                endDate: "\(finances[0].endDate!)"
            )
            
            newCellFinance.deleaget = self
            newCellFinance.finance = finances[0]
            
            contentView.addSubview(newCellFinance)
            
            NSLayoutConstraint.activate([
                
                newCellFinance.topAnchor.constraint(equalTo: contentView.topAnchor),
                newCellFinance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newCellFinance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newCellFinance.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            if finances.count > 1 {
                
                for i in 1..<finances.count {
                    
                    let cellFinance = FinanceCell(
                        startDate: "\(finances[i].startDate!)",
                        endDate: "\(finances[i].endDate!)"
                    )
                    
                    cellFinance.deleaget = self
                    cellFinance.finance = finances[i]
                    
                    contentView.addSubview(cellFinance)
                    
                    NSLayoutConstraint.activate([
                        
                        cellFinance.topAnchor.constraint(equalTo: newCellFinance.bottomAnchor),
                        cellFinance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellFinance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellFinance.heightAnchor.constraint(equalToConstant: 50),
                    ])
                    
                    newCellFinance = cellFinance
                }
            }
        }
    }
    
    @objc
    private func addFinanceButtonTapped() {
        let vc = CreateFinanceViewController()

        guard let project = MainDataManager.shared.project else { return }

        vc.project = project
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension FinanceListViewController: FinanceCellDelegate {
    
    func dedSelectCell(_ cell: FinanceCell) {
        let vc = ChosenFinanceViewController()
        
        MainDataManager.shared.finance = cell.finance
        
        guard let window = self.view.window else { return }
        
        window.contentViewController = vc
    }
}

extension FinanceListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchFinances()
    }
}
