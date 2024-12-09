//
//  ProjectDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 07.12.2024.
//

import Cocoa

final class ProjectDataManager {
    
    static let shared = ProjectDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createProject(startDate: Date, endDate: Date, mainGoal: String, user: User) {
        
        let project = Project(context: context)
        
        project.startData = startDate
        project.endDate = endDate
        project.mainGoal = mainGoal
        project.userToProject = user
        
        MainDataManager.shared.saveContext()

    }
    
    func fetchAllProjectsByUser(user: User) -> [Project] {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.predicate = NSPredicate(format: "userToProject == %@", user)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all projects \(error)")
            return []
        }
    }
    
    func fetchProject(user: User, mainGoal: String) -> Project? {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.predicate = NSPredicate(format: "mainGoal == %@ AND userToProject == %@", mainGoal, user)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error by fetch project \(error)")
            return nil
        }
    }
    
    func updateProject(byUser: User, byMainGoal: String, startDate: Date, endDate: Date) {
        
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.predicate = NSPredicate(format: "userToProject == %@ AND mainGoal == %@", byUser, byMainGoal)
        
        do {
            let project: Project? = try context.fetch(request).first
            
            guard let project = project else {
                print("!!!Error by fetch project to update")
                return
            }
            
            project.startData = startDate
            project.endDate = endDate
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("!!!Error to update project \(error)")
        }
    }
    
    func deleteProject(project: Project) {
        
        context.delete(project)
        print("mb deleted")
        MainDataManager.shared.saveContext()
    }
}
