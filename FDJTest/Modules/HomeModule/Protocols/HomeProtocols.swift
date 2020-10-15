//
//  HomeProtocols.swift
//  FDJTest
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import Foundation
protocol HomeViewProtocol {
    func showTeams(teams: [Team])
    func showLeagues(leagues: [League])
    func showTeamsError(error: String)
}

protocol HomePresenterProtocol {
    func getAllLeaguesFetchedWithSuccess(leagues: Leagues)
    func getAllLeaguesFetchedWithFailure(error: Error)
    func getTeamsFetchedWithSuccess(teams: Teams)
    func getTeamsFetchedWithFailure(error: Error)
}
