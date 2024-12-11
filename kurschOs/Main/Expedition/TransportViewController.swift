//
//  TransportViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class TransportViewController: NSViewController {
    
    private var transports: [Vehicle] = []
    
    private lazy var addTransportButton: NSButton = {
        let button = NSButton()
        button.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        button.bezelColor = NSColor.systemGreen
        button.target = self
        button.action = #selector(addTransportButtonTapped)
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
        fetchTransports()
    }
    
    private func setupHierarchy() {
        view.addSubview(addTransportButton)
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            addTransportButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            addTransportButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            
            verticalScrollView.topAnchor.constraint(equalTo: addTransportButton.bottomAnchor, constant: 5),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func fetchTransports() {
        
        guard let expedition = MainDataManager.shared.expedtion else { return }
        
        transports = TransportDataManager.shared.fetchAllTransports(expedition: expedition)
        
        if !transports.isEmpty {
            
            var newTransportCell = TransportCell(
                transportType: transports[0].transportType!,
                model: transports[0].model!,
                registerNumber: transports[0].registerNumber!,
                licenceCategory: transports[0].lecenceCategory!,
                passengers: "\(transports[0].passengers)",
                capacity: "\(transports[0].capacity)"
            )
            
            contentView.addSubview(newTransportCell)
            
            NSLayoutConstraint.activate([
                
                newTransportCell.topAnchor.constraint(equalTo: contentView.topAnchor),
                newTransportCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                newTransportCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                newTransportCell.heightAnchor.constraint(equalToConstant: 150),
            ])
            
            if transports.count > 1 {
                
                for i in 1..<transports.count {
                    
                    let cellTransport = TransportCell(
                        transportType: transports[i].transportType!,
                        model: transports[i].model!,
                        registerNumber: transports[i].registerNumber!,
                        licenceCategory: transports[i].lecenceCategory!,
                        passengers: "\(transports[i].passengers)",
                        capacity: "\(transports[i].capacity)"
                    )
                    
                    contentView.addSubview(cellTransport)
                    
                    NSLayoutConstraint.activate([
                        
                        cellTransport.topAnchor.constraint(equalTo: newTransportCell.bottomAnchor),
                        cellTransport.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                        cellTransport.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                        cellTransport.heightAnchor.constraint(equalToConstant: 150),
                    ])
                    
                    newTransportCell = cellTransport
                }
            }
        }
    }
    
    @objc
    private func addTransportButtonTapped() {
        let vc = CreateTransportViewController()

        guard let expedition = MainDataManager.shared.expedtion else { return }

        vc.expedition = expedition
        vc.delegate = self
        
        self.presentAsModalWindow(vc)
    }
}

extension TransportViewController: ModalDismissProtocol {
    
    func modalDismiss() {
        fetchTransports()
    }
}
