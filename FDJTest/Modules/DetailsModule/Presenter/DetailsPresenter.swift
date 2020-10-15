//
//  DetailsPresenter.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 06/10/2020.
//

import Foundation

class DetailsPresenter {
    private let detailsServices: DetailsServices
    private var detailsViewProtocol: DetailsViewProtocol?
    
    init(detailsServices: DetailsServices) {
        self.detailsServices = detailsServices
        self.detailsServices.presenter = self
    }
    
    func setViewProtocol(detailsViewProtocol: DetailsViewProtocol) {
        self.detailsViewProtocol = detailsViewProtocol
    }
    
    func getTeam(with teamName: String) {
        detailsServices.getTeamDetails(with: teamName)
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    func getTeamDetailsFetchedWithSuccess(teams: Teams) {
        if let team = teams.teams?.first {
            self.detailsViewProtocol?.showTeamDetails(team: team)
        }
    }
    
    func getTeamDetailsFetchedWithFailure(error: Error) {
        self.detailsViewProtocol?.showTeamDetailsError(error: error.localizedDescription)
    }
}
