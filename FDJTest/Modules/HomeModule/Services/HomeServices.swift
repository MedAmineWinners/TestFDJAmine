//
//  HomeServices.swift
//  FDJTest
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import Foundation
class HomeServices {
    var presenter: HomePresenterProtocol?
    var requestHandler = RequestHandler()
    /// getAllLeagues
    /// returs a completion of all the leagues available in the API otherwhise an error
    func getAllLeagues() {
        let url = getURL(matching: .allLeagues, queryName: nil, queryValue: nil)
        requestHandler.loadData(from: url) { result in
            switch result {
            case .success(let result):
                let leagues: Leagues = result.decode()
                self.presenter?.getAllLeaguesFetchedWithSuccess(leagues: leagues)
            case .failure(let error):
                self.presenter?.getAllLeaguesFetchedWithFailure(error: error)
            }
        }
    }
    
    /// get Teams
    /// returns a completion of all the teams of a choosen League available in the API otherwhise an error
    /// - Parameter : 'leagueName'
    func getTeams(with leagueName: String) {
        let url = getURL(matching: .allTeams, queryName: .leaguesQuery, queryValue: leagueName)
        requestHandler.loadData(from: url) { result in
            switch result {
            case .success(let result):
                let teams: Teams = result.decode()
                self.presenter?.getTeamsFetchedWithSuccess(teams: teams)
            case .failure(let error):
                self.presenter?.getTeamsFetchedWithFailure(error: error)
            }
        }
    }
}
