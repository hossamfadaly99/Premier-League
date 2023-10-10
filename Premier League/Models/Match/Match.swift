//
//  Match.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct Match: Codable {
    let id: Int?
    let season: Season?
    let utcDate: String?
    let status: Status?
    let matchday: Int?
    let stage: String?
    let lastUpdated: String?
    let odds: Odds?
    let score: Score?
    let homeTeam, awayTeam: Area?
    let referees: [Referee]?
}

enum Status: String, Codable {
    case finished = "FINISHED"
    case scheduled = "SCHEDULED"
}
