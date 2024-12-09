//
//  ExpeditionDataManger.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 08.12.2024.
//

import Cocoa

final class ExpeditionDataManger {
    
    static let shared = ExpeditionDataManger()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createExpedition(startDate: Date, endDate: Date, expeditionName: String, expeditionType: String, mainGoal: String, path: String, project: Project) {
        
        let expedition = Expedition(context: context)
        
        expedition.startDate = startDate
        expedition.endDate = endDate
        expedition.expeditionName = expeditionName
        expedition.mainGoal = mainGoal
        expedition.path = path
        expedition.expeditionType = expeditionType
        expedition.expeditionToProject = project
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllExpeditionByProject(project: Project) ->  [Expedition] {
        
        let request: NSFetchRequest<Expedition> = Expedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@", project)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all expedition \(error)")
            return []
        }
    }
    
    func fetchExpedition(project: Project, mainGoal: String) -> Expedition? {
        
        let request: NSFetchRequest<Expedition> = Expedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@ AND mainGoal == %@", project, mainGoal)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch expedition \(error)")
            return nil
        }
    }
    
    func updateExpedition(project: Project, mainGoal: String, startDate: Date, endDate: Date, expeditionName: String, expeditionType: String) {
        
        let request: NSFetchRequest<Expedition> = Expedition.fetchRequest()
        request.predicate = NSPredicate(format: "expeditionToProject == %@ AND mainGoal == %@", project, mainGoal)
        
        do {
            let expedition: Expedition? = try context.fetch(request).first
            
            guard let expedition = expedition else {
                print("!!!Error by th")
                return
            }
            
            expedition.startDate = startDate
            expedition.endDate = endDate
            expedition.expeditionName = expeditionName
            expedition.expeditionType = expeditionType
            
            MainDataManager.shared.saveContext()
        } catch {
            print("error to update expedition \(error)")
        }
    }
    
    func deleteExpedition(expedition: Expedition) {
        
        context.delete(expedition)
        MainDataManager.shared.saveContext()
    }
}
