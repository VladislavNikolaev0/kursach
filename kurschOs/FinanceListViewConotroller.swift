//
//  FinanceList.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class FinanceListViewController: NSViewController {
    
    private lazy var testFinance = FinanceCell(
        startDate: "12.12.24",
        endDate: "12.12.25"
    )
    
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
        addCell()
    }
    
    private func setupHierarchy() {
        view.addSubview(verticalScrollView)
        verticalScrollView.documentView = contentView
        view.addSubview(testFinance)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func addCell() {
        contentView.addSubview(testFinance)
        
        NSLayoutConstraint.activate([
            testFinance.topAnchor.constraint(equalTo: contentView.topAnchor),
            testFinance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            testFinance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testFinance.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
