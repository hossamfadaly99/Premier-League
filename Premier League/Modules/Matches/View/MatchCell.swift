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
  @IBOutlet weak var infoBackgroundView: UIView!
  @IBOutlet weak var statusBackgroundView: UIView!

  var dataHandler: ((MatchModel) -> Void) = {_ in}
  var match: MatchModel!

  override func awakeFromNib() {
    super.awakeFromNib()
    Utilities.makeCellBorderRadius(cell: self)
  }

  override func layoutSubviews() {
          super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 4, right: 16))
      }

  func updateUI(match: MatchModel) {
    homeTeamLabel.text = match.homeTeam
    awayTeamLabel.text = match.awayTeam
    matchStatusLabel.text = match.status
    matchInfoLabel.text = match.info
    matchdayLabel.text = match.matchDay
    if match.isFav {
      self.favButton.setImage(UIImage(systemName: Constants.HEART_FILLED_ICON)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
      self.favButton.tintColor = .red
    } else {
      self.favButton.setImage(UIImage(systemName: Constants.HEART_ICON)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
    }
    infoBackgroundView.backgroundColor = match.infoBackround
    statusBackgroundView.backgroundColor = match.statusBackround
    self.match = match
  }
  
  @IBAction func favButtonTapped(_ sender: UIButton) {
    dataHandler(match)
  }
}
