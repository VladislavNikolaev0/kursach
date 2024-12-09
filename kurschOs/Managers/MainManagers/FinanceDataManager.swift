//
//  FinanceDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 08.12.2024.
//

import Cocoa

final class FinanceDataManager {
    
    static let shared = FinanceDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createExpedition(startDate: Date, endDate: Date) {
        
        let fiance = FinanceModule(context: context)
        
        fiance.startDate = startDate
        fiance.endDate = endDate
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllFinanceByProject(project: Project) ->  [FinanceModule] {
        
        let request: NSFetchRequest<FinanceModule> = FinanceModule.fetchRequest()
        request.predicate = NSPredicate(format: "financeModuleToProject == %@", project)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all expedition \(error)")
            return []
        }
    }
    
    func fetchFinance(project: Project, hash: Int) -> FinanceModule? {
        
        let request: NSFetchRequest<FinanceModule> = FinanceModule.fetchRequest()
        request.predicate = NSPredicate(format: "financeModuleToProject == %@ AND hash == %@", project,  hash)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch finance \(error)")
            return nil
        }
    }
    
    func updateFinance(project: Project, hash: Int, startDate: Date, endDate: Date) {
        
        let request: NSFetchRequest<FinanceModule> = FinanceModule.fetchRequest()
        request.predicate = NSPredicate(format: "financeModuleToProject == %@ AND hash == %@", project, hash)
        
        do {
            let finance: FinanceModule? = try context.fetch(request).first
            
            guard let finance = finance else {
                print("!!!Error by th")
                return
            }
            
            finance.startDate = startDate
            finance.endDate = endDate
            
            MainDataManager.shared.saveContext()
        } catch {
            print("error to update expedition \(error)")
        }
    }
    
    func deleteFinance(finance: FinanceModule) {
        
        context.delete(finance)
        MainDataManager.shared.saveContext()
    }
}
