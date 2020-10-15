//
//  Leagues.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation

struct Leagues: Codable {
    let leagues: [League]?

    enum CodingKeys: String, CodingKey {
        case leagues = "leagues"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        leagues = try values.decodeIfPresent([League].self, forKey: .leagues)
    }

}

struct League: Codable {
    let idLeague: String?
    let strLeague: String?
    let strSport: String?
    let strLeagueAlternate: String?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idLeague = try values.decodeIfPresent(String.self, forKey: .idLeague)
        strLeague = try values.decodeIfPresent(String.self, forKey: .strLeague)
        strSport = try values.decodeIfPresent(String.self, forKey: .strSport)
        strLeagueAlternate = try values.decodeIfPresent(String.self, forKey: .strLeagueAlternate)
    }
}
