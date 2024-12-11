//
//  AProjectDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class AProjectDataManager {
    
    static let shared = AProjectDataManager()
    
    var context = MainAnaliticDataManger.shared.context
    
    private init() {}
    
    func createProject(startDate: Date, endDate: Date, mainGoal: String, user: User) {
        
        let aproject = AProject(context: context)
        
        aproject.startDate = startDate
        aproject.endDate = endDate
        aproject.mainGoal = mainGoal
        
        MainAnaliticDataManger.shared.saveContext()
        
        let project = Project(context: MainDataManager.shared.context)
        
        project.startData = startDate
        project.endDate = endDate
        project.mainGoal = mainGoal
        project.userToProject = user
        
        MainDataManager.shared.project = project
        MainDataManager.shared.saveContext()

    }
    
    func fetchAllProjects() -> [AProject] {
        
        let request: NSFetchRequest<AProject> = AProject.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all projects \(error)")
            return []
        }
    }
    
    func fetchProject(mainGoal: String) -> AProject? {
        
        let request: NSFetchRequest<AProject> = AProject.fetchRequest()
        request.predicate = NSPredicate(format: "mainGoal == %@ ", mainGoal)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch project \(error)")
            return nil
        }
    }
    
    func updateProject(byUser: User, byMainGoal: String, startDate: Date, endDate: Date) {
        
        let request: NSFetchRequest<AProject> = AProject.fetchRequest()
        request.predicate = NSPredicate(format: "mainGoal == %@", byMainGoal)
        
        do {
            let project: AProject? = try context.fetch(request).first
            
            guard let project = project else {
                print("!!!Error by fetch project to update")
                return
            }
            
            project.startDate = startDate
            project.endDate = endDate
            
            MainAnaliticDataManger.shared.saveContext()
            
        } catch {
            print("!!!Error to update project \(error)")
        }
    }
    
    func deleteProject(project: AProject) {
        
        context.delete(project)
        MainAnaliticDataManger.shared.saveContext()
    }
}
