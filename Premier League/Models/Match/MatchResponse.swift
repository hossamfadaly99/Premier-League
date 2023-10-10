//
//  Match.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct MatchResponse: Codable {
    let count: Int?
    let competition: Competition?
    let matches: [Match]?
}
