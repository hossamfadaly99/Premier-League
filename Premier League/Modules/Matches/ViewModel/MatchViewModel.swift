//
//  MatchViewModel.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

class MatchViewModel {

  private var networkManager: Networkable
  private var dbManager: Cachable
  var groupedMatches: [[MatchModel]] = []
  var updateViewController: () -> () = {}

  init(networkManager: Networkable, dbManager: Cachable) {
    self.networkManager = networkManager
    self.dbManager = dbManager
  }

  func fetchMatches() {
    let paramters = [Constants.DATE_FROM: Utilities.getcurrentDate(), Constants.DATE_TO: "2023-10-23"]

    networkManager.fetchData(url: "\(Constants.BASE_URL)competitions/2021/matches", param: paramters) { [weak self] (matchResponse: MatchResponse?) in
      guard let self = self, let matchResponse = matchResponse, let matches = matchResponse.matches else { return }

      calculateSectionCount(matches)
      getFavMatches { favMatches in
        for (groupIndex, groupedMatch) in self.groupedMatches.enumerated() {
        outerLoop: for (matchIndex, match) in groupedMatch.enumerated() {
            for favMatch in favMatches {
              if match.id == favMatch.id {
                self.groupedMatches[groupIndex][matchIndex].isFav = true
                continue outerLoop
              }
            }
          }
        }
        self.updateViewController()
      }

    }
  }

  func removeFavMatches(match: MatchModel) {
    dbManager.removeFavMatches(match)
  }

  func getFavMatches(completion: @escaping ([MatchModel])-> Void) {
    let favMatches = dbManager.getFavoriteMatches()
    completion(favMatches)
  }

  func addMatchToFavorites(match: MatchModel) {
    dbManager.insertMatch(match)
  }

  private func calculateSectionCount(_ matches: [Match]) {
    groupedMatches = []
    matches.forEach( { match in
      let matchDate = Utilities.convertUTCtoYYYYMMDD(match.utcDate)
      if let sectionIndex = groupedMatches.firstIndex(where: { $0.first?.date == matchDate }) {
        groupedMatches[sectionIndex].append(MatchModel(match: match))
      } else {
        groupedMatches.append([MatchModel(match: match)])
      }
    })
  }

  private func getMappedMatchsModel(with model: MatchResponse) -> [MatchModel]? {
    guard let fullMatchesModel = model.matches else { return nil }
    var mappedMatchesModel: [MatchModel] = []
    for match in fullMatchesModel {
      mappedMatchesModel.append(MatchModel(match: match))
    }
    return mappedMatchesModel
  }
}
