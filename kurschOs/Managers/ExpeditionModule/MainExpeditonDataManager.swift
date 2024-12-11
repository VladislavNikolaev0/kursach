//
//  MainExpeditonDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class MainExpeditonDataManager {
    
    static let shared = MainExpeditonDataManager()
    
    var project: EProject?
    var expedition: EExpedition?
    var team: ETeam?
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExpeditionModel")
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
