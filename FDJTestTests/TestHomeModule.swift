//
//  TestHomeModule.swift
//  FDJTestTests
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import XCTest
@testable import FDJTest

class TestHomeModule: XCTestCase {
    var requestHandler: RequestHandler!
    let session = NetworkSessionMock()
    let homeServices = HomeServices()
    let presenter = HomePresenterMock()
    override func setUp() {
        super.setUp()
        requestHandler = RequestHandler(session: session)
        homeServices.presenter = presenter
        homeServices.requestHandler = requestHandler
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchLeaguesAndTeams() {

        let leaguesPath = "file://"+Bundle(for: type(of: self)).path(forResource: "Leagues", ofType: "json")!
        guard let leaguesExpectedData = try? Data(contentsOf: URL(string: leaguesPath)!) else {
            fatalError("No data for url \(leaguesPath)")
        }
        //Test getAllLeague with success
        session.data = leaguesExpectedData
        session.error = nil
        homeServices.getAllLeagues()
        XCTAssertTrue(presenter.leaguesFetchedWithSuccessCalled)
        
        //Test getAllLeagues with failure
        session.data = nil
        session.error = NetworkingError.internalError
        homeServices.getAllLeagues()
        XCTAssertTrue(presenter.leaguesFetchedWithFailureCalled)
        
        let teamsPath = "file://"+Bundle(for: type(of: self)).path(forResource: "Teams", ofType: "json")!
        
        guard let teamsExpectedData = try? Data(contentsOf: URL(string: teamsPath)!) else {
            fatalError("No data for url \(teamsPath)")
        }
        //Test getTeams with success
        session.data = teamsExpectedData
        session.error = nil
        homeServices.getTeams(with: "")
        XCTAssertTrue(presenter.teamsFetchedWithSuccessCalled)
        
        //Test getTeams with failure
        session.data = nil
        session.error = NetworkingError.internalError
        homeServices.getTeams(with: "")
        XCTAssertTrue(presenter.teamsFetchedWithFailureCalled)
    }
}

class HomePresenterMock: HomePresenterProtocol {
    var leaguesFetchedWithSuccessCalled = false
    var leaguesFetchedWithFailureCalled = false
    var teamsFetchedWithSuccessCalled = false
    var teamsFetchedWithFailureCalled = false
    func getAllLeaguesFetchedWithSuccess(leagues: Leagues) {
        leaguesFetchedWithSuccessCalled = true
    }
    
    func getAllLeaguesFetchedWithFailure(error: Error) {
        leaguesFetchedWithFailureCalled = true
    }
    
    func getTeamsFetchedWithSuccess(teams: Teams) {
        teamsFetchedWithSuccessCalled = true
    }
    
    func getTeamsFetchedWithFailure(error: Error) {
        teamsFetchedWithFailureCalled = true
    }
}
