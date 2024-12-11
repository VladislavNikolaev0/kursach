//
//  ProjectSideBarController.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 03.12.2024.
//

import Cocoa

final class ProjectSideBarController: NSViewController {
    
    private let items = [
        "Исследовательский модуль",
        "Аналитичекский модуль",
        "Финансовый модуль"]
    
    private lazy var table = NSTableView()
    
    private let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("ColumnIdentifier"))
    
    var swicher: ProjectSpitProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        confugure()
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
    }
}

extension ProjectSideBarController: NSTableViewDelegate, NSTableViewDataSource {
    
    private func confugure() {
        column.width = 200
        table.addTableColumn(column)
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier("CellIdentifier")
        
        var cell = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView
        
        if cell == nil {
            cell = NSTableCellView()
            cell?.identifier = cellIdentifier
            
            let textField = NSTextField(labelWithString: items[row])
            textField.translatesAutoresizingMaskIntoConstraints = false
            cell?.addSubview(textField)
            
            NSLayoutConstraint.activate([
                textField.leadingAnchor.constraint(equalTo: cell!.leadingAnchor),
                textField.trailingAnchor.constraint(equalTo: cell!.trailingAnchor),
                textField.topAnchor.constraint(equalTo: cell!.topAnchor),
                textField.bottomAnchor.constraint(equalTo: cell!.bottomAnchor),
            ])
        } else {
            cell?.textField?.stringValue = items[row]
        }
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let selectedRow = table.selectedRow
        
        switch selectedRow {
        case 0:
            swicher?.getControllerToChild(ExpeditionListViewController())
        case 1:
            swicher?.getControllerToChild(AnalyticalListViewController())
        case 2:
            swicher?.getControllerToChild(FinanceListViewController())
        default:
            break
        }
    }
}
