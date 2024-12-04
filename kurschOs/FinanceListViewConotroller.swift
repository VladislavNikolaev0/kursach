//
//  FinanceList.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class FinanceListViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.systemMint.cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
