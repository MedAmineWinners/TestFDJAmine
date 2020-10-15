//
//  RequestHandler.swift
//  FDJTest
//
//  Created by Mohamed Lamine Belfekih on 15/10/2020.
//

import Foundation
protocol NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL,
                  completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { (data, _, error) in
            completionHandler(data, error)
        }
        task.resume()
    }
}

class RequestHandler {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func loadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        session.loadData(from: url) { (data, error) in
            let result = data.map(Result.success) ?? .failure(error ?? NetworkingError.internalError)
            completion(result)
        }
    }
}

enum NetworkingError: Error {
    case internalError
    
    var localizedDescription: String {
        switch self {
        case .internalError:
            return "An error occured, please try later"
        }
    }
}

enum SearchQueryName: String {
    case leaguesQuery = "l"
    case teamsQuery = "t"
}

enum SearchPaths: String {
    case allLeagues = "/api/v1/json/1/all_leagues.php"
    case allTeams = "/api/v1/json/1/search_all_teams.php"
    case team = "/api/v1/json/1/searchteams.php"
}

func getURL(matching searchPath: SearchPaths, queryName: SearchQueryName?,
            queryValue: String?
) -> URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.thesportsdb.com"
    components.path = searchPath.rawValue
    if let name = queryName?.rawValue {
        components.queryItems = [
            URLQueryItem(name: name, value: queryValue)
        ]
    }
    return components.url!
}


