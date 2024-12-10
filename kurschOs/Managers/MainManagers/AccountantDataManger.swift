//
//  AccountantDataManget.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class AccountantDataManger {
    
    static let shared = AccountantDataManger()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createAccountant(firstName: String, lastName: String, birthDate: Date, position: String, team: Team) {
        
        let accountant = Accountant(context: context)
        accountant.firstName = firstName
        accountant.lastName = lastName
        accountant.birthDate = birthDate
        accountant.position = position
        accountant.accountantToTeam = team
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllCountant(team: Team) -> [Accountant] {
        
        let request: NSFetchRequest<Accountant> = Accountant.fetchRequest()
        request.predicate = NSPredicate(format: "accountantToTeam == %@", team)
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func fetchAccountant(team: Team, firstName: String, lastName: String) -> Accountant? {
        
        let request: NSFetchRequest<Accountant> = Accountant.fetchRequest()
        request.predicate = NSPredicate(format: "accountantToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateAccountant(team: Team, firstName: String, lastName: String, birthDate: Date, position: String) {
        
        let request: NSFetchRequest<Accountant> = Accountant.fetchRequest()
        request.predicate = NSPredicate(format: "accountantToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let accountant = try context.fetch(request).first
            
            guard let accountant else { return }
            
            accountant.firstName = firstName
            accountant.lastName = lastName
            accountant.birthDate = birthDate
            accountant.position = position
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error in \(error)")
        }
    }
    
    func deleteAccountant(accountant: Accountant) {
        
        context.delete(accountant)
        
        MainDataManager.shared.saveContext()
    }
    
    func setPassport(passport: Passport, team: Team, firstName: String, lastName: String) {
        
        let request: NSFetchRequest<Accountant> = Accountant.fetchRequest()
        request.predicate = NSPredicate(format: "accountantToTeam == %@ AND firstName == %@ AND lastName == %@", team, firstName, lastName)
        
        do {
            let accountant = try context.fetch(request).first
            
            guard let accountant else { return }
            
            accountant.accountantToPassport = passport
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error in set passport")
        }
    }
}
