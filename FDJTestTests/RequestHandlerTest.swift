//
//  RequestHandlerTest.swift
//  FDJTestTests
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import XCTest
@testable import FDJTest

class RequestHandlerTests: XCTestCase {
    
    var requestHandler: RequestHandler!
    let session = NetworkSessionMock()
   
    override func setUp() {
        super.setUp()
         requestHandler = RequestHandler(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoadData() {

        let expectedData = "_".data(using: .utf8)
        
        session.data = expectedData
        var actualData: Data?
        requestHandler.loadData(from: URL(string: "https://www.google.com")!) { result in
            switch result {
            case .success(let data):
                actualData = data
            case .failure(_):
                print("")
            }
        }
        XCTAssertNotNil(actualData)
        session.data = nil
        session.error = NetworkingError.internalError
        var actualError: Error?
        requestHandler.loadData(from: URL(string: "https://www.google.com")!) { result in
            switch result {
            case .success(_):
                print("")
            case .failure(let error):
                actualError = error
            }
        }
        XCTAssertNotNil(actualError)
        
        session.data = nil
        session.error = nil
        requestHandler.loadData(from: URL(string: "https://www.google.com")!) { result in
            switch result {
            case .success(_):
                print("")
            case .failure(let error):
                actualError = error
            }
        }
        XCTAssertNotNil(actualError)
    }
}
