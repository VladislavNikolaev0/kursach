//
//  AnalyticalListViewController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class AnalyticalListViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.cyan.cgColor
        
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
