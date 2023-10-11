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
  @IBOutlet weak var matchInfoLabel: UILabel!
  @IBOutlet weak var favButton: UIButton!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
