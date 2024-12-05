//
//  EqupmentListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 04.12.2024.
//

import Cocoa

final class EqupmentListViewController: NSViewController {
    
    private lazy var testEqupment = EqupmentCell(name: "Broad", count: "12", weight: "3")
    
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
        //view.addSubview(testTeam)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: verticalScrollView.topAnchor, constant: 5),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.trailingAnchor, constant: -5),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.bottomAnchor),
        ])
    }
    
    private func addCell() {
        contentView.addSubview(testEqupment)
        
        NSLayoutConstraint.activate([
            testEqupment.topAnchor.constraint(equalTo: contentView.topAnchor),
            testEqupment.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            testEqupment.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            testEqupment.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
