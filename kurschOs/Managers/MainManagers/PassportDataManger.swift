//
//  PassportDataManger.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 10.12.2024.
//

import Cocoa

final class PassportDataManger {
    
    static let shared = PassportDataManger()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createPassowrdByReseacher(number: String, issuedBy: String, issuedDate: Date, reseacher: Researcher) -> Passport {
        
        let passport = Passport(context: context)
        
        passport.number = number
        passport.issuedBy = issuedBy
        passport.issuedDate = issuedDate
        passport.passportToResearcher = reseacher
        
        MainDataManager.shared.saveContext()
        
        return passport
    }
    
    func createPassowrdByAnalyst(number: String, issuedBy: String, issuedDate: Date, analyst: Analyst) -> Passport {
        
        let passport = Passport(context: context)
        
        passport.number = number
        passport.issuedBy = issuedBy
        passport.issuedDate = issuedDate
        passport.passportToAnalyst = analyst
        
        MainDataManager.shared.saveContext()
        
        return passport
    }
    
    func createPassowrdByAccountnatn(number: String, issuedBy: String, issuedDate: Date, accountant: Accountant) -> Passport {
        
        let passport = Passport(context: context)
        
        passport.number = number
        passport.issuedBy = issuedBy
        passport.issuedDate = issuedDate
        passport.passportToAccountant = accountant
        
        MainDataManager.shared.saveContext()
        
        return passport
    }
    
    func fetchPassportByResearcher(reseacher: Researcher) -> Passport? {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToResearcher == %@", reseacher)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func fetchPassportByAnalyst(analyst: Analyst) -> Passport? {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToAnalyst == %@", analyst)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func fetchPassportByAccountant(accountant: Accountant) -> Passport? {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToAccountant == %@", accountant)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updatePassportByReseacher(reseacher: Researcher, number: String, issuedBy: String, issuedDate: Date) {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToResearcher == %@", reseacher)
        
        do {
            let passport = try context.fetch(request).first
            
            guard let passport else { return }
            
            passport.number = number
            passport.issuedBy = issuedBy
            passport.issuedDate = issuedDate
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error updating passport")
        }
    }
    
    func updatePassportByAnalyst(analyst: Analyst, number: String, issuedBy: String, issuedDate: Date) {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToAnalyst == %@", analyst)
        
        do {
            let passport = try context.fetch(request).first
            
            guard let passport else { return }
            
            passport.number = number
            passport.issuedBy = issuedBy
            passport.issuedDate = issuedDate
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error updating passport")
        }
    }
    
    func updatePassportByAccountant(accountant: Accountant, number: String, issuedBy: String, issuedDate: Date) {
        
        let request: NSFetchRequest<Passport> = Passport.fetchRequest()
        request.predicate = NSPredicate(format: "passportToAccountant == %@", accountant)
        
        do {
            let passport = try context.fetch(request).first
            
            guard let passport else { return }
            
            passport.number = number
            passport.issuedBy = issuedBy
            passport.issuedDate = issuedDate
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("Error updating passport")
        }
    }
    
    func deletePassport(passport: Passport) {
        
        context.delete(passport)
        
        MainDataManager.shared.saveContext()
    }
}
