//
//  EqupmentListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class EqupmentListViewController: NSViewController {
    
    private var equpments: [Equpment] = []
    
    private lazy var addEqupmentButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addEqupmentButtonTapped)
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
        fetchEquipment()
    }
    
    private func setupHierarchy() {
        view.addSubview(addEqupmentButton)
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addEqupmentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            addEqupmentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addEqupmentButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchEquipment() {
        
        guard let expedition = MainDataManager.shared.expedtion else { return }
        
        equpments = EqupmentDataManager.shared.fetchAllEqupments(expedition: expedition)
        
        if !equpments.isEmpty {
            
            var newEqupmentCell = EqupmentCell(
                name: equpments[0].name!,
                count: "\(equpments[0].count)",
                weight: "\(equpments[0].weight)"
            )
            
            contentView.addSubview(newEqupmentCell)
            
            NSLayoutConstraint.activate([
                
                newEqupmentCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                newEqupmentCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newEqupmentCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newEqupmentCell.heightAnchor.constraint(equalToConstant: 100),
            ])
            
            if equpments.count > 1 {
                
                for i in 1..<equpments.count {
                    
                    let cellEqupment = EqupmentCell(
                        name: equpments[i].name!,
                        count: "\(equpments[i].count)",
                        weight: "\(equpments[i].weight)"
                    )
                    
                    contentView.addSubview(cellEqupment)
                    
                    NSLayoutConstraint.activate([
                        
                        cellEqupment.topAnchor.constraint(equalTo: newEqupmentCell.bottomAnchor),
                        cellEqupment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellEqupment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellEqupment.heightAnchor.constraint(equalToConstant: 100),
                    ])
                    
                    newEqupmentCell = cellEqupment
                }
            }
            
        }
    }
    
    @objc
    private func addEqupmentButtonTapped() {
        let vc = CreateEqupmentViewController()

        guard let expedition = MainDataManager.shared.expedtion else { return }

        vc.expedition = expedition
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension EqupmentListViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchEquipment()
    }
}
