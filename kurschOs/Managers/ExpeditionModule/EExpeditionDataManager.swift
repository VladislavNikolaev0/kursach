//
//  EExpeditionDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class EExpeditionDataManager {
    
    static let shared = EExpeditionDataManager()
    
    var context = MainExpeditonDataManager.shared.context
    
    private init() {}
    
    func createExpedition(startDate: Date, endDate: Date, expeditionName: String, expeditionType: String, mainGoal: String, path: String, project: Project, eproject: EProject) {
        
        let eexpedition = EExpedition(context: context)
        
        eexpedition.startDate = startDate
        eexpedition.endDate = endDate
        eexpedition.expeditionName = expeditionName
        eexpedition.mainGoal = mainGoal
        eexpedition.expeditionType = expeditionType
        eexpedition.expeditionToProject = eproject
        
        MainExpeditonDataManager.shared.saveContext()
        
        let expedition = Expedition(context: MainDataManager.shared.context)
        
        expedition.startDate = startDate
        expedition.endDate = endDate
        expedition.expeditionName = expeditionName
        expedition.mainGoal = mainGoal
        expedition.path = path
        expedition.expeditionType = expeditionType
        expedition.expeditionToProject = project
        
        MainDataManager.shared.saveContext()
    }
    
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
