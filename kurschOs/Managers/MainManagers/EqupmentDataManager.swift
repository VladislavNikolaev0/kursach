//
//  EqupmentDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class EqupmentDataManager {
    
    static let shared = EqupmentDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createEqupment(name: String, conunt: Int, weight: Double, expedition: Expedition) {
        
        let equipment = Equpment(context: context)
        
        equipment.name = name
        equipment.count = Int32(conunt)
        equipment.weight = weight
        equipment.equpmentToExpediton = expedition
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllEqupments(expedition: Expedition) -> [Equpment] {
        
        let request: NSFetchRequest<Equpment> = Equpment.fetchRequest()
        request.predicate = NSPredicate(format: "equpmentToExpediton == %@", expedition)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchEqupment(expedition: Expedition, name: String) -> Equpment? {
        
        let request: NSFetchRequest<Equpment> = Equpment.fetchRequest()
        request.predicate = NSPredicate(format: "equpmentToExpediton == %@ AND name == %@", expedition, name)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateTransport(name: String, conunt: Int, weight: Double, expedition: Expedition) {
        
        let request: NSFetchRequest<Equpment> = Equpment.fetchRequest()
        request.predicate = NSPredicate(format: "equpmentToExpediton == %@ AND name == %@", expedition, name)
        
        do {
            
            let equipment = try context.fetch(request).first
            
            guard let equipment else { return }
            
            equipment.name = name
            equipment.count = Int32(conunt)
            equipment.weight = weight
            equipment.equpmentToExpediton = expedition
            
            MainDataManager.shared.saveContext()
            
        } catch {
            
            print("Error")
        }
    }
    
    func deleteEqupment(equpment: Equpment) {
        
        context.delete(equpment)
        MainDataManager.shared.saveContext()
    }
}
