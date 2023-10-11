//
//  MatchViewModel.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

class MatchViewModel {

  var networkManager: Networkable
  var groupedMatches: [[MatchModel]] = []
  var updateViewController: () -> () = {}

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func fetchMatches() {
    let paramters = [Constants.DATE_FROM: Utilities.getcurrentDate(), Constants.DATE_TO: Utilities.getNextYearDate()]

    networkManager.fetchData(url: "\(Constants.BASE_URL)competitions/2021/matches", param: paramters) { [weak self] (matchResponse: MatchResponse?) in
      guard let self = self, let matchResponse = matchResponse, let matches = matchResponse.matches else { return }

      calculateSectionCount(matches)
      self.updateViewController()
    }
  }

  private func calculateSectionCount(_ matches: [Match]) {
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
