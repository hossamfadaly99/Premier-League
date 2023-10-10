//
//  aaa.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct Score: Codable {
    let winner: Winner?
    let duration: String?
    let fullTime, halfTime, extraTime, penalties: ExtraTime?
}

enum Winner: String, Codable {
    case awayTeam = "AWAY_TEAM"
    case draw = "DRAW"
    case homeTeam = "HOME_TEAM"
}
