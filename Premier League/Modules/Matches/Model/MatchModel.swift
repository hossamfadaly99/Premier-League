//
//  MatchModel.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct MatchModel {
  var isFav: Bool? = false
  let status: Status?
  let matchDate: String?
  let winner: Winner?
  let score: String?
  let homeTeam: String?
  let awayTeam: String?
}
