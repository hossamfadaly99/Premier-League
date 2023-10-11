//
//  MatchViewModel.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

class MatchViewModel {

  var networkManager: Networkable
  var matches: [MatchModel] = []
  var updateViewController: () -> () = {}

  init(networkManager: Networkable) {
    self.networkManager = networkManager
  }

  func fetchMatches() {
    let paramters = [Constants.DATE_FROM: Utilities.getcurrentDate(), Constants.DATE_TO: Utilities.getNextYearDate()]

    networkManager.fetchData(url: "\(Constants.BASE_URL)competitions/2021/matches", param: paramters) { [weak self] (matchResponse: MatchResponse?) in
      guard let self = self, let matchResponse = matchResponse, let matches = self.getMappedMatchsModel(with: matchResponse) else { return }
      self.matches = matches
      self.updateViewController()
    }
  }

  func getMappedMatchsModel(with model: MatchResponse) -> [MatchModel]? {
    guard let fullMatchesModel = model.matches else { return nil }
    var mappedMatchesModel: [MatchModel] = []
    for match in fullMatchesModel {
      mappedMatchesModel.append(MatchModel(match: match))
    }
    return mappedMatchesModel
  }
}
