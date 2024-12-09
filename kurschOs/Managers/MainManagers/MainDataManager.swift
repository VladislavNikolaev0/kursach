//
//  MainDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 07.12.2024.
//

import Cocoa
import CoreData

final class MainDataManager {
    static let shared = MainDataManager()
    
    var user: User?
    var project: Project?
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error as? NSError {
                fatalError("!!!!Error get persistent container \(error)")
            } else {
                print(description.url?.absoluteString ?? "None")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("!!!Error to save context \(error.localizedDescription) \(error.userInfo)")
            }
        }
    }
    
    func logDataPath() {
        if let url = persistentContainer.persistentStoreCoordinator.persistentStores.first?.url {
            print(url)
        } else {
            print("Can't get url db")
        }
    }
}
