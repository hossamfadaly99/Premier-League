//
//  MatchModel.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct MatchModel {
  let id: Int?
  let status: String?
  let homeTeam: String?
  let awayTeam: String?
  let info: String?
  let matchDay: String?
  let date: String?
  private let homeScore: Int?
  private let awayScore: Int?

  init(match: Match) {
    self.id = match.id
    self.status = match.status?.rawValue.capitalized
    homeScore = match.score?.extraTime?.homeTeam ?? match.score?.fullTime?.homeTeam ?? match.score?.halfTime?.homeTeam
    awayScore = match.score?.extraTime?.awayTeam ?? match.score?.fullTime?.awayTeam ?? match.score?.halfTime?.awayTeam
    date = Utilities.convertUTCtoYYYYMMDD(match.utcDate)
    if match.status == .finished {
      self.info = "\(homeScore ?? 0) - \(awayScore ?? 0)"
    } else {
      self.info = Utilities.convertUTCtoHHMM(match.utcDate)
    }
    self.matchDay = "Matchday #\(match.matchday ?? 0)"
    self.homeTeam = match.homeTeam?.name
    self.awayTeam = match.awayTeam?.name

  }
}
