//
//  LeaguesAPIServices.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation
class LeaguesAPIServices {
    
    /// getAllLeagues
    /// returs a completion of all the leagues available in the API otherwhise an error
    func getAllLeagues(completion: @escaping (_ leagues: Leagues?, _ error: LeagueServicesError?) -> Void) {
        let url = getURL(matching: .allLeagues, queryName: nil, queryValue: nil)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let leagues = try? JSONDecoder().decode(Leagues.self, from: data) {
                    completion(leagues, nil)
                }
            }else {
                completion(nil, .leagueError)
            }
        }.resume()
    }
    
    /// get Teams
    /// returns a completion of all the teams of a choosen League available in the API otherwhise an error
    /// - Parameter : 'leagueName'
    func getTeams(with leagueName: String, completion: @escaping (_ teams: Teams?, _ error: LeagueServicesError?) -> Void) {
        let url = getURL(matching: .allTeams, queryName: .leaguesQuery, queryValue: leagueName)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let teams = try? JSONDecoder().decode(Teams.self, from: data) {
                    completion(teams, nil)
                }
            }else {
                completion(nil, .teamError)
            }
        }.resume()
    }
    
    /// getTeamDetails
    /// returns a completion of a team  otherwhise an error
    /// - Parameter : 'TeamName'
    func getTeamDetails(with teamName: String, completion: @escaping (_ team: Team?, _ error: LeagueServicesError?) -> Void) {
        let url = getURL(matching: .team, queryName: .teamsQuery, queryValue: teamName)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let teams = try? JSONDecoder().decode(Teams.self, from: data) {
                    completion(teams.teams?.first, nil)
                }
            }else {
                completion(nil, .teamError)
            }
        }.resume()
    }
}

/// Simulation of an enum error
/// two cases of a my founded errors
enum LeagueServicesError: Error {
    case leagueError
    case teamError
    
    var localizedDescription: String {
        switch self {
        case .leagueError:
            return "Test FDJ error, please try later"
        case .teamError:
            return "Test FDJ error, please try later"
        }
    }
}
