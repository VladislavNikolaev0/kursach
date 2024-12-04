//
//  ExpeditionListViewContrller.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ExpeditionListViewController: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemGray.cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
