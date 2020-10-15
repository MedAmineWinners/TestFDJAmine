//
//  TestDetailsModule.swift
//  FDJTestTests
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import XCTest
@testable import FDJTest

class TestDetailsModule: XCTestCase {
    var requestHandler: RequestHandler!
    let session = NetworkSessionMock()
    let detailsServices = DetailsServices()
    let presenter = DetailsPresenterMock()
    override func setUp() {
        super.setUp()
        requestHandler = RequestHandler(session: session)
        detailsServices.presenter = presenter
        detailsServices.requestHandler = requestHandler
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchLeaguesAndTeams() {

        let teamPath = "file://"+Bundle(for: type(of: self)).path(forResource: "Teams", ofType: "json")!
        guard let teamExpectedData = try? Data(contentsOf: URL(string: teamPath)!) else {
            fatalError("No data for url \(teamPath)")
        }
        //Test getTeamDetails with success
        session.data = teamExpectedData
        session.error = nil
        detailsServices.getTeamDetails(with: "")
        XCTAssertTrue(presenter.teamDetailsFetchedWithSuccess)
        
        //Test getTeamDetails with failure
        session.data = nil
        session.error = NetworkingError.internalError
        detailsServices.getTeamDetails(with: "")
        XCTAssertTrue(presenter.teamDetailsFetchedWithFailure)
    }
}

class DetailsPresenterMock: DetailsPresenterProtocol {
    var teamDetailsFetchedWithSuccess = false
    var teamDetailsFetchedWithFailure = false
  
    func getTeamDetailsFetchedWithSuccess(teams: Teams) {
        teamDetailsFetchedWithSuccess = true
    }
    
    func getTeamDetailsFetchedWithFailure(error: Error) {
        teamDetailsFetchedWithFailure = true
    }
}

