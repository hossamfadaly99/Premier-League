//
//  Cachable.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

protocol Cachable {
  func getFavoriteMatches() -> [MatchModel]
  func insertMatch(_ match: MatchModel)
  func removeFavMatches(_ match: MatchModel)
}
