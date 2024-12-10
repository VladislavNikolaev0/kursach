//
//  TransportDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class TransportDataManager {
    
    static let shared = TransportDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createTransport(transprotType: String, model: String, registerNumber: String, lecenceCategory: String, passengers: Int, capacity: Double, expedition: Expedition) {
        
        let transport = Vehicle(context: context)
        
        transport.transportType = transprotType
        transport.model = model
        transport.registerNumber = registerNumber
        transport.lecenceCategory = lecenceCategory
        transport.passengers = Int16(passengers)
        transport.capacity = capacity
        transport.vehicleToExpedition = expedition
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllTransports(expedition: Expedition) -> [Vehicle] {
        
        let request: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        request.predicate = NSPredicate(format: "vehicleToExpedition == %@", expedition)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchTransport(expedition: Expedition, registerNumber: String) -> Vehicle? {
        
        let request: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        request.predicate = NSPredicate(format: "vehicleToExpedition == %@ AND registerNumber == %@", expedition, registerNumber)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateTransport(transprotType: String, model: String, registerNumber: String, lecenceCategory: String, passengers: Int, capacity: Double, expedition: Expedition) {
        
        let request: NSFetchRequest<Vehicle> = Vehicle.fetchRequest()
        request.predicate = NSPredicate(format: "vehicleToExpedition == %@ AND registerNumber == %@", expedition, registerNumber)
        
        do {
            
            let transport = try context.fetch(request).first
            
            guard let transport else { return }
            
            transport.transportType = transprotType
            transport.model = model
            transport.registerNumber = registerNumber
            transport.lecenceCategory = lecenceCategory
            transport.passengers = Int16(passengers)
            transport.capacity = capacity
            
            MainDataManager.shared.saveContext()
            
        } catch {
            
            print("Error")
        }
    }
    
    func deleteTransprot(transport: Vehicle) {
        
        context.delete(transport)
        MainDataManager.shared.saveContext()
    }
}
