//
//  UserDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 07.12.2024.
//

import Cocoa

final class UserDataManager {
    
    static let shared = UserDataManager()
    
    private init() {}
    
    var context = MainDataManager.shared.context
    
    func createUser(email: String, firstName: String, lastName: String, login: String, password: String) {
        
        let user = User(context: context)
        user.email = email
        user.fistName = firstName
        user.lastName = lastName
        user.login = login
        user.password = password
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error can't fetch users: \(error)")
            return []
        }
    }
    
    func fetchUser(login: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", login)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("!!!Error can't fetch this user \(error)")
            return nil
        }
    }
    
    func updateUser(byLogin: String, email: String, firstName: String, lastName: String, password: String) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "login == %@", byLogin)
        
        do {
            let user: User? = try context.fetch(request).first
            
            guard let user = user else {
                print("!!!Error user in update is nil")
                return
            }
            
            user.email = email
            user.fistName = firstName
            user.lastName = lastName
            user.password = password
            
            MainDataManager.shared.saveContext()
            
        } catch {
            print("!!!Error can't update user \(error)")
        }
    }
    
    
    func deleteUser(user: User) {
        context.delete(user)
        MainDataManager.shared.saveContext()
    }
}
