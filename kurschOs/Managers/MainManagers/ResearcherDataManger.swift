//
//  ResearcherDataManger.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class ResearcherDataManger {
    
    static let shared = ResearcherDataManger()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createResearcher(firstName: String, lastName: String, birthDate: Date, driverLecence: String, position: String, team: Team) -> Researcher {
        
        let researcher = Researcher(context: context)
        
        researcher.fisrtName = firstName
        researcher.lastName = lastName
        researcher.birthDate = birthDate
        researcher.driveLecence = driverLecence
        researcher.position = position
        researcher.researcherToTeam = team
        
        MainDataManager.shared.saveContext()
        
        return researcher
    }
    
    func fetchAllResearchersByTeam(team: Team) -> [Researcher] {
        
        let request: NSFetchRequest<Researcher> = Researcher.fetchRequest()
        request.predicate = NSPredicate(format: "researcherToTeam == %@", team)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchResearcher(team: Team, firstName: String, lastName: String) -> Researcher? {
        
        let request: NSFetchRequest<Researcher> = Researcher.fetchRequest()
        request.predicate = NSPredicate(format: "researcherToTeam == %& AND fisrtName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateResearcher(team: Team, firstName: String, lastName: String, birthDate: Date, driverLecence: String, position: String) {
        
        let request: NSFetchRequest<Researcher> = Researcher.fetchRequest()
        request.predicate = NSPredicate(format: "researcherToTeam == %& AND fisrtName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let researcher = try context.fetch(request).first
            
            guard let researcher else { return }
            
            researcher.fisrtName = firstName
            researcher.lastName = lastName
            researcher.birthDate = birthDate
            researcher.driveLecence = driverLecence
            researcher.position = position
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error is \(error)")
        }
    }
    
    func deleteResearchers(researcher: Researcher) {
        
        context.delete(researcher)
        MainDataManager.shared.saveContext()
    }
    
    func setPassportAndCard(passport: Passport, card: MedecineCard, team: Team, firstName: String, lastName: String) {
        
        let request: NSFetchRequest<Researcher> = Researcher.fetchRequest()
        request.predicate = NSPredicate(format: "researcherToTeam == %@ AND fisrtName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let researcher = try context.fetch(request).first
            
            guard let researcher else { return }
            
            researcher.researcherToPassport = passport
            researcher.researcherToMedecineCard = card
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error in set passport")
        }
    }
}
