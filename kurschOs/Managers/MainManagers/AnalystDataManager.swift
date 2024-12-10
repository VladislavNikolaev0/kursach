//
//  AnaliystDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AnalystDataManager {
    
    static let shared = AnalystDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createAnalyst(firstName: String, lastName: String, birthDate: Date, position: String, team: Team) {
        
        let analyst = Analyst(context: context)
        
        analyst.firstName = firstName
        analyst.lastName = lastName
        analyst.birthDate = birthDate
        analyst.position = position
        analyst.analystToTeam = team
        
        MainDataManager.shared.saveContext()
        
    }
    
    func fetchAllAnalystsByTeam(team: Team) -> [Analyst] {
        
        let request: NSFetchRequest<Analyst> = Analyst.fetchRequest()
        request.predicate = NSPredicate(format: "analystToTeam == %@", team)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchAnalyst(team: Team, firstName: String, lastName: String) -> Analyst? {
        
        let request: NSFetchRequest<Analyst> = Analyst.fetchRequest()
        request.predicate = NSPredicate(format: "analystToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateAnalyst(team: Team, firstName: String, lastName: String, birthDate: Date, position: String) {
        
        let request: NSFetchRequest<Analyst> = Analyst.fetchRequest()
        request.predicate = NSPredicate(format: "analystToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let analyst = try context.fetch(request).first
            
            guard let analyst else { return }
            
            analyst.firstName = firstName
            analyst.lastName = lastName
            analyst.birthDate = birthDate
            analyst.position = position
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error is \(error)")
        }
    }
    
    func deletAnalyst(analyst: Analyst) {
        
        context.delete(analyst)
        
        MainDataManager.shared.saveContext()
    }
    
    func setPassport(passport: Passport, team: Team, firstName: String, lastName: String) {
        
        let request: NSFetchRequest<Analyst> = Analyst.fetchRequest()
        request.predicate = NSPredicate(format: "analystToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let analyst = try context.fetch(request).first
            
            guard let analyst else { return }
            
            analyst.analystToPassport = passport
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error in set passport")
        }
    }
}
