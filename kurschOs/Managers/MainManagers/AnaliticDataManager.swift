//
//  AnaliticDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 09.12.2024.
//

import Cocoa

final class AnaliticDataManager {
    
    static let shared = AnaliticDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createAnalitic(startDate: Date, mainGoal: String, analiticType: String, project: Project) {
        
        let analitic = Analitical(context: context)
        
        analitic.startDate = startDate
        analitic.mainGoal = mainGoal
        analitic.analiticType = analiticType
        analitic.analiticalToProject = project
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllAnaliticByProject(project: Project) ->  [Analitical] {
        
        let request: NSFetchRequest<Analitical> = Analitical.fetchRequest()
        request.predicate = NSPredicate(format: "analiticalToProject == %@", project)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all expedition \(error)")
            return []
        }
    }
    
    func fetchAnalitical(project: Project, mainGoal: String) -> Analitical? {
        
        let request: NSFetchRequest<Analitical> = Analitical.fetchRequest()
        request.predicate = NSPredicate(format: "analiticalToProject == %@ AND mainGoal == %@", project, mainGoal)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch expedition \(error)")
            return nil
        }
    }
    
    func updateAnalitical(project: Project, mainGoal: String, startDate: Date, analiticType: String) {
        
        let request: NSFetchRequest<Analitical> = Analitical.fetchRequest()
        request.predicate = NSPredicate(format: "analiticalToProject == %@ AND mainGoal == %@", project, mainGoal)
        
        do {
            let analitic: Analitical? = try context.fetch(request).first
            
            guard let analitic = analitic else {
                print("!!!Error by th")
                return
            }
            
            analitic.startDate = startDate
            analitic.mainGoal = mainGoal
            analitic.analiticType = analiticType
            
            MainDataManager.shared.saveContext()
        } catch {
            print("error to update expedition \(error)")
        }
    }
    
    func deleteAnalitic(analitic: Analitical) {
        
        context.delete(analitic)
        MainDataManager.shared.saveContext()
    }
}
