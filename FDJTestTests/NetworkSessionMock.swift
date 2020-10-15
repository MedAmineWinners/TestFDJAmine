//
//  NetworkSessionMock.swift
//  FDJTestTests
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import XCTest
@testable import FDJTest

class NetworkSessionMock: NetworkSession {
    var data: Data?
    var error: Error?

    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        completionHandler(data, error)
    }
}
