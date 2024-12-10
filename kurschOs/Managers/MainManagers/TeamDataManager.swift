//
//  TeamDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 09.12.2024.
//

import Cocoa

final class TeamDataManager {
    
    static let shared = TeamDataManager()
    
    var context = MainDataManager.shared.context
    
    private init() {}
    
    func createTeamByExpedition(teamName: String, teamType: String, expedition: Expedition) {
        
        let team = Team(context: context)
        
        team.teamName = teamName
        team.teamType = teamType
        team.teamToExpedition = expedition
        
        MainDataManager.shared.saveContext()
    }
    
    func createTeamByAnalitic(teamName: String, teamType: String, analitic: Analitical) {
        
        let team = Team(context: context)
        
        team.teamName = teamName
        team.teamType = teamType
        team.teamToAnalitical = analitic
        
        MainDataManager.shared.saveContext()
    }
    
    func createTeamByFinance(teamName: String, teamType: String, finance: FinanceModule) {
        
        let team = Team(context: context)
        
        team.teamName = teamName
        team.teamType = teamType
        team.teamToFinanceModule = finance
        
        MainDataManager.shared.saveContext()
    }
    
    func fetchAllTeamsByExpetion(expedition: Expedition) -> [Team] {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@", expedition)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all team in expdetion")
            return []
        }
    }
    
    func fetchAllTeamsByAnalitic(analitic: Analitical) -> [Team] {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToAnalitical == %@", analitic)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all team in analitic")
            return []
        }
    }
    
    func fetchAllTeamsByFinance(finance: FinanceModule) -> [Team] {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToFinanceModule == %@", finance)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all team in finance")
            return []
        }
    }
    
    func fetchTeamByExpedition(expedition: Expedition, teamName: String) -> Team? {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@ AND teamName == %@", expedition, teamName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func fetchTeamByAnalitic(analitic: Analitical, teamName: String) -> Team? {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToAnalitical == %@ AND teamName == %@", analitic, teamName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func fetchTeamByFinance(finance: FinanceModule, teamName: String) -> Team? {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToFinanceModule == %@ AND teamName == %@", finance, teamName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateTeamByExpedition(expedition: Expedition, teamName: String, teamType: String) {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@ AND teamName == %@", expedition, teamName)
        
        do {
            
            let team = try context.fetch(request).first
            
            guard let team else { return }
            
            team.teamName = teamName
            team.teamType = teamType
            
            MainDataManager.shared.saveContext()
        } catch {
            print("Dont update team by expedition")
        }
    }
    
    func updateTeamByAnalitic(analitic: Analitical, teamName: String, teamType: String) {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToAnalitical == %@ AND teamName == %@", analitic, teamName)
        
        do {
            
            let team = try context.fetch(request).first
            
            guard let team else { return }
            
            team.teamName = teamName
            team.teamType = teamType
            
            MainDataManager.shared.saveContext()
        } catch {
            print("Dont update team by analitic")
        }
    }
    
    func updateTeamByFinance(finance: FinanceModule, teamName: String, teamType: String) {
        
        let request: NSFetchRequest<Team> = Team.fetchRequest()
        request.predicate = NSPredicate(format: "teamToFinanceModule == %@ AND teamName == %@", finance, teamName)
        
        do {
            
            let team = try context.fetch(request).first
            
            guard let team else { return }
            
            team.teamName = teamName
            team.teamType = teamType
            
            MainDataManager.shared.saveContext()
        } catch {
            print("Dont update team by finance")
        }
    }
    
    func deleteTeam(team: Team) {
        
        context.delete(team)
        MainDataManager.shared.saveContext()
    }
}
