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
  var dataHandler: ((MatchModel) -> Void) = {_ in}
  var match: MatchModel!

  func updateUI(match: MatchModel) {
    homeTeamLabel.text = match.homeTeam
    awayTeamLabel.text = match.awayTeam
    matchStatusLabel.text = match.status
    matchInfoLabel.text = match.info
    matchdayLabel.text = match.matchDay
    if match.isFav {
      self.favButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
      self.favButton.tintColor = .red
    } else {
        self.favButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }
    self.match = match
  }

  private func animateButton(_ button: UIButton) {
    UIView.animate(withDuration: 0.3, animations: {
      button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

      button.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
      button.tintColor = .red
    }) { _ in
      UIView.animate(withDuration: 0.3) {
        button.transform = .identity
      }
    }
  }

  @IBAction func favButtonTapped(_ sender: UIButton) {
    if !match.isFav {
      animateButton(self.favButton)
    } else {
      self.favButton.setImage(UIImage(systemName: "heart")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }
    dataHandler(match)
  }
}
