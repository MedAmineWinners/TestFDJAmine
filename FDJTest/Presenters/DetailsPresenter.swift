//
//  DetailsPresenter.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 06/10/2020.
//

import Foundation

protocol DetailsViewProtocol {
    func showTeamDetails(team: Team)
    func showTeamDetailsError(error: String)
}

class DetailsPresenter {
    private let leaguesAPIServices: LeaguesAPIServices
    private var detailsViewProtocol: DetailsViewProtocol?
    
    init(leaguesAPIServices: LeaguesAPIServices) {
        self.leaguesAPIServices = leaguesAPIServices
    }
    
    func setViewProtocol(detailsViewProtocol: DetailsViewProtocol) {
        self.detailsViewProtocol = detailsViewProtocol
    }
    
    func getTeam(with teamName: String) {
        leaguesAPIServices.getTeamDetails(with: teamName) { (team, error) in
            if let team = team {
                self.detailsViewProtocol?.showTeamDetails(team: team)
                return
            }
            self.detailsViewProtocol?.showTeamDetailsError(error: error!.localizedDescription)
        }
    }
}
