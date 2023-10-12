//
//  MatchModel.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation
import UIKit

struct MatchModel {
  let id: Int?
  let status: String?
  let homeTeam: String?
  let awayTeam: String?
  let info: String?
  let matchDay: String?
  let date: String?
  let homeScore: Int?
  let awayScore: Int?
  var isFav: Bool = false
  var infoBackround: UIColor?
  var statusBackround: UIColor?

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
    self.matchDay = "\(Constants.MATCHDAY)\(match.matchday ?? 0)"
    self.homeTeam = match.homeTeam?.name
    self.awayTeam = match.awayTeam?.name
    if match.status == .finished {
      statusBackround = UIColor(named: Constants.ANCHOR_COLOR)
      infoBackround = UIColor(named: Constants.ORANGE_COLOR)
    } else {
      statusBackround = UIColor(named: Constants.COIN_COLOR)
      infoBackround = UIColor(named: Constants.LIGHT_GREEN_COLOR)
    }
  }
}
