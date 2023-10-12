//
//  Cachable.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

protocol Cachable {
  func getFavoriteMatches() -> [Int]
  func insertMatch(_ match: MatchModel)
  func removeFavMatche(with id: Int32)
}
