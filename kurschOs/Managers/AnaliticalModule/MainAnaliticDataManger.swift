//
//  MainAnaliticDataManger.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class MainAnaliticDataManger {
    
    static let shared = MainAnaliticDataManger()
    
    var project: AProject?
    var analitic: AAnalitical?
    var team: ATeam?
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AnaliticModel")
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
        persistentContainer.viewContext
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
}
