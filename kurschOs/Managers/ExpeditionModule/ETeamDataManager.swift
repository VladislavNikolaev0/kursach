//
//  ETeamDataManager.swift
//  kurschOs
//
//  Created by Ангел предохранитель on 11.12.2024.
//

import Cocoa

final class ETeamDataManager {
    
    static let shared = ETeamDataManager()
    
    var context = MainExpeditonDataManager.shared.context
    
    private init() {}
    
    func createTeamByExpedition(teamName: String, teamType: String, expedition: Expedition, eexpedition: EExpedition) {
        
        let eteam = ETeam(context: context)
        
        eteam.teamName = teamName
        eteam.teamType = teamType
        eteam.teamToExpedition = eexpedition
        
        MainExpeditonDataManager.shared.saveContext()
    }
    
    func fetchAllTeamsByExpetion(expedition: EExpedition) -> [ETeam] {
        
        let request: NSFetchRequest<ETeam> = ETeam.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@", expedition)
        
        do {
            return try context.fetch(request)
        } catch {
            print("!!!Error by fetch all team in expdetion")
            return []
        }
    }
    
    func fetchTeamByExpedition(expedition: EExpedition, teamName: String) -> ETeam? {
        
        let request: NSFetchRequest<ETeam> = ETeam.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@ AND teamName == %@", expedition, teamName)
        
        do {
            return try context.fetch(request).first
        } catch {
            return nil
        }
    }
    
    func updateTeamByExpedition(expedition: EExpedition, teamName: String, teamType: String) {
        
        let request: NSFetchRequest<ETeam> = ETeam.fetchRequest()
        request.predicate = NSPredicate(format: "teamToExpedition == %@ AND teamName == %@", expedition, teamName)
        
        do {
            
            let team = try context.fetch(request).first
            
            guard let team else { return }
            
            team.teamName = teamName
            team.teamType = teamType
            
            MainExpeditonDataManager.shared.saveContext()
        } catch {
            print("Dont update team by expedition")
        }
    }
    
    func deleteTeam(team: ETeam) {
        
        context.delete(team)
        MainExpeditonDataManager.shared.saveContext()
    }
}
