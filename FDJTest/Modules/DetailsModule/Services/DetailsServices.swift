//
//  DetailsServices.swift
//  FDJTest
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import Foundation
class DetailsServices {
    var presenter: DetailsPresenterProtocol?
    var requestHandler = RequestHandler()
    func getTeamDetails(with teamName: String) {
        let url = getURL(matching: .team, queryName: .teamsQuery, queryValue: teamName)
        requestHandler.loadData(from: url) { result in
            switch result {
            case .success(let result):
                let teams: Teams = result.decode()
                self.presenter?.getTeamDetailsFetchedWithSuccess(teams: teams)
            case .failure(let error):
                self.presenter?.getTeamDetailsFetchedWithFailure(error: error)
            }
        }
    }
}
