//
//  DetailsProtocol.swift
//  FDJTest
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import Foundation

protocol DetailsViewProtocol {
    func showTeamDetails(team: Team)
    func showTeamDetailsError(error: String)
}

protocol DetailsPresenterProtocol {
    func getTeamDetailsFetchedWithSuccess(teams: Teams)
    func getTeamDetailsFetchedWithFailure(error: Error)
}
