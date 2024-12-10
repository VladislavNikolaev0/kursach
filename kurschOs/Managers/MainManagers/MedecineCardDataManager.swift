//
//  MedecineCardDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class MedecineCardDataManager {
    
    static let shared = MedecineCardDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createMedCard(allergies: String, chronicDeseases: String, heightPerson: Int, weightPerson: Double, medecineCheckup: Date) {
        
        let card = MedecineCard(context: context)
        
        card.allergies = allergies
        card.chronicDeseases = chronicDeseases
        card.heightPerson = Int32(heightPerson)
        card.weightPerson = weightPerson
        card.medecineCheckup = medecineCheckup
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchMedCard(researcher: Researcher) -> MedecineCard? {
        
        let request: NSFetchRequest<MedecineCard> = MedecineCard.fetchRequest()
        request.predicate = NSPredicate(format: "medecineCardToResearcher == %@", researcher)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateMedCard(allergies: String, chronicDeseases: String, heightPerson: Int, weightPerson: Double, medecineCheckup: Date, researcher: Researcher) {
        
        let request: NSFetchRequest<MedecineCard> = MedecineCard.fetchRequest()
        request.predicate = NSPredicate(format: "medecineCardToResearcher == %@", researcher)
        
        do {
            let card = try context.fetch(request).first
            
            guard let card else { return }
            
            card.allergies = allergies
            card.chronicDeseases = chronicDeseases
            card.heightPerson = Int32(heightPerson)
            card.weightPerson = weightPerson
            card.medecineCheckup = medecineCheckup
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error update card")
        }
    }
    
    func deleteCard(card: MedecineCard) {
        
        context.delete(card)
        
        MainDataManager.shared.saveContext()
    }
    
    func setResearcher(researcher: Researcher, allergies: String, chronicDeseases: String, heightPerson: Int32) {
        
        let request: NSFetchRequest<MedecineCard> = MedecineCard.fetchRequest()
        request.predicate = NSPredicate(format: "allergies == %@ AND chronicDeseases == %@ AND heightPerson == %@", allergies, chronicDeseases, heightPerson)
        
        do {
            let card = try context.fetch(request).first
            
            guard let card else { return }
            
            card.medecineCardToResearcher = researcher
            
            MainDataManager.shared.saveContext()
        } catch {
            print("Error in set reseacher")
        }
    }
}
