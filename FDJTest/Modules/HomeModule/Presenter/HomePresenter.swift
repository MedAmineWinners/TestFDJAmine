//
//  HomePresenter.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation
class HomePresenter {
    private let homeServices: HomeServices
    private var homeViewProtocol: HomeViewProtocol?
    private var leagues = [League]()
    init(homeServices: HomeServices) {
        self.homeServices = homeServices
        self.homeServices.presenter = self
    }
    
    func setViewProtocol(homeViewProtocol: HomeViewProtocol) {
        self.homeViewProtocol = homeViewProtocol
    }
    
    func prepareLeaguesForSearch() {
        homeServices.getAllLeagues()
    }
    
    func getLeagues(with initials: String) {
        if self.leagues.count > 0 {
            self.homeViewProtocol?.showLeagues(leagues: self.leagues.filter { $0.strLeague!.contains(initials)})
        }
    }
    
    func getTeams(for leagueName: String){
        homeServices.getTeams(with: leagueName)
    }
}

extension HomePresenter: HomePresenterProtocol {
    func getAllLeaguesFetchedWithSuccess(leagues: Leagues) {
        if let leagues = leagues.leagues {
            self.leagues = leagues.filter { $0.strSport == "Soccer"}
        }
    }
    
    func getAllLeaguesFetchedWithFailure(error: Error) {
        self.homeViewProtocol?.showTeamsError(error: error.localizedDescription)
    }
    
    func getTeamsFetchedWithSuccess(teams: Teams) {
        if let teams = teams.teams {
            self.homeViewProtocol?.showTeams(teams: teams)
        }
    }
    
    func getTeamsFetchedWithFailure(error: Error) {
        self.homeViewProtocol?.showTeamsError(error: error.localizedDescription)
    }
}
