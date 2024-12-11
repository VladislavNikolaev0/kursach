//
//  EProjectDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class EProjectDataManager {
    
    static let shared = EProjectDataManager()
    
    var context = MainExpeditonDataManager.shared.context
    
    private init() {}
    
    func createProject(startDate: Date, endDate: Date, mainGoal: String, user: User) {
        
        let eproject = EProject(context: context)
        
        eproject.startDate = startDate
        eproject.endDate = endDate
        eproject.mainGoal = mainGoal
        
        MainExpeditonDataManager.shared.saveContext()
        
        let project = Project(context: MainDataManager.shared.context)
        
        project.startData = startDate
        project.endDate = endDate
        project.mainGoal = mainGoal
        project.userToProject = user
        
        MainDataManager.shared.project = project
        MainDataManager.shared.saveContext()

    }
    
    func fetchAllProjects() -> [EProject] {
        
        let request: NSFetchRequest<EProject> = EProject.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all projects \(error)")
            return []
        }
    }
    
    func fetchProject(mainGoal: String) -> EProject? {
        
        let request: NSFetchRequest<EProject> = EProject.fetchRequest()
        request.predicate = NSPredicate(format: "mainGoal == %@ ", mainGoal)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch project \(error)")
            return nil
        }
    }
    
    func updateProject(byUser: User, byMainGoal: String, startDate: Date, endDate: Date) {
        
        let request: NSFetchRequest<EProject> = EProject.fetchRequest()
        request.predicate = NSPredicate(format: "mainGoal == %@", byMainGoal)
        
        do {
            let project: EProject? = try context.fetch(request).first
            
            guard let project = project else {
                print("!!!Error by fetch project to update")
                return
            }
            
            project.startDate = startDate
            project.endDate = endDate
            
            MainExpeditonDataManager.shared.saveContext()
            
        } catch {
            print("!!!Error to update project \(error)")
        }
    }
    
    func deleteProject(project: EProject) {
        
        context.delete(project)
        MainExpeditonDataManager.shared.saveContext()
    }
}
