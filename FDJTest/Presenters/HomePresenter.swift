//
//  HomePresenter.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation

protocol HomeViewProtocol {
    func showTeams(teams: [Team])
    func showLeagues(leagues: [League])
    func showTeamsError(error: String)
}

class HomePresenter {
    private let leaguesAPIServices: LeaguesAPIServices
    private var homeViewProtocol: HomeViewProtocol?
    private var leagues: [League]!
    init(leaguesAPIServices: LeaguesAPIServices) {
        self.leaguesAPIServices = leaguesAPIServices
    }
    
    func setViewProtocol(homeViewProtocol: HomeViewProtocol) {
        self.homeViewProtocol = homeViewProtocol
    }
    
    func prepareLeaguesForSearch() {
        leaguesAPIServices.getAllLeagues { (leagues, error) in
            if let leagues = leagues?.leagues {
                self.leagues = leagues.filter { $0.strSport == "Soccer"}
            }
        }
    }
    
    func getLeagues(with initials: String) {
        if self.leagues != nil {
            self.homeViewProtocol?.showLeagues(leagues: self.leagues.filter { $0.strLeague!.contains(initials)})
        }
    }
    
    func getTeams(for leagueName: String){
        leaguesAPIServices.getTeams(with: leagueName) { (teams, error) in
            if let teams = teams?.teams {
                self.homeViewProtocol?.showTeams(teams: teams)
                return
            }
            self.homeViewProtocol?.showTeamsError(error: error?.localizedDescription ?? "")
        }
    }
}
