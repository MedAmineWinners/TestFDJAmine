//
//  URLGenerator.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 06/10/2020.
//

import Foundation

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
