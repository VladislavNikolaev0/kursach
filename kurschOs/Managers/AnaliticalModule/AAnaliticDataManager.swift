//
//  AAnaliticDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class AAnaliticDataManager {
    
    static let shared = AAnaliticDataManager()
    
    var context = MainAnaliticDataManger.shared.context
    
    private init() {}
    
    
    func fetchAllExpeditionByProject(eproject: EProject) ->  [EExpedition] {
        
        let request: NSFetchRequest<EExpedition> = EExpedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@", eproject)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all expedition \(error)")
            return []
        }
    }
    
    func fetchExpedition(eproject: EProject, mainGoal: String) -> EExpedition? {
        
        let request: NSFetchRequest<EExpedition> = EExpedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@ AND mainGoal == %@", eproject, mainGoal)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch expedition \(error)")
            return nil
        }
    }
    
    func updateExpedition(eproject: EProject, mainGoal: String, startDate: Date, endDate: Date, expeditionName: String, expeditionType: String) {
        
        let request: NSFetchRequest<EExpedition> = EExpedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@ AND mainGoal == %@", eproject, mainGoal)
        
        do {
            let expedition: EExpedition? = try context.fetch(request).first
            
            guard let expedition = expedition else {
                print("!!!Error by th")
                return
            }
            
            expedition.startDate = startDate
            expedition.endDate = endDate
            expedition.expeditionName = expeditionName
            expedition.expeditionType = expeditionType
            
            MainExpeditonDataManager.shared.saveContext()
        } catch {
            print("error to update expedition \(error)")
        }
    }
    
    func deleteExpedition(expedition: EExpedition) {
        
        context.delete(expedition)
        MainExpeditonDataManager.shared.saveContext()
    }
}
