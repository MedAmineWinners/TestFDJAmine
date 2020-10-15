//
//  Teams.swift
//  FDJTest
//
//  Created by Med Amine Belfkih on 05/10/2020.
//

import Foundation
struct Teams: Codable {
    let teams: [Team]?

    enum CodingKeys: String, CodingKey {
        case teams = "teams"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teams = try values.decodeIfPresent([Team].self, forKey: .teams)
    }
}

struct Team: Codable {
    let idTeam: String?
    let strTeam: String?
    let strLeague: String?
    let strDescriptionEN: String?
    let strCountry: String?
    let strTeamBadge: String?
    let strTeamBanner: String?

    enum CodingKeys: String, CodingKey {
        case idTeam = "idTeam"
        case strTeam = "strTeam"
        case strLeague = "strLeague"
        case strDescriptionEN = "strDescriptionEN"
        case strCountry = "strCountry"
        case strTeamBadge = "strTeamBadge"
        case strTeamBanner = "strTeamBanner"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idTeam = try values.decodeIfPresent(String.self, forKey: .idTeam)
        strTeam = try values.decodeIfPresent(String.self, forKey: .strTeam)
        strLeague = try values.decodeIfPresent(String.self, forKey: .strLeague)
        strDescriptionEN = try values.decodeIfPresent(String.self, forKey: .strDescriptionEN)
        strCountry = try values.decodeIfPresent(String.self, forKey: .strCountry)
        strTeamBadge = try values.decodeIfPresent(String.self, forKey: .strTeamBadge)
        strTeamBanner = try values.decodeIfPresent(String.self, forKey: .strTeamBanner)
    }
}
