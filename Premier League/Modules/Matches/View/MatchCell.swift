//
//  MatchCell.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import UIKit

class MatchCell: UITableViewCell {

  @IBOutlet weak var homeTeamLabel: UILabel!
  @IBOutlet weak var awayTeamLabel: UILabel!
  @IBOutlet weak var matchStatusLabel: UILabel!
  @IBOutlet weak var matchdayLabel: UILabel!
  @IBOutlet weak var matchInfoLabel: UILabel!
  @IBOutlet weak var favButton: UIButton!

  func updateUI(match: MatchModel) {
    homeTeamLabel.text = match.homeTeam
    awayTeamLabel.text = match.awayTeam
    matchStatusLabel.text = match.status
    matchInfoLabel.text = match.info
    matchdayLabel.text = match.matchDay
  }

}
