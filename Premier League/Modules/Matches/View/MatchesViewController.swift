//
//  ViewController.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import UIKit

class MatchesViewController: UIViewController {

  @IBOutlet weak var matchesTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
  }

  private func setupTableView() {
    let matchCell = UINib(nibName: "MatchCell", bundle: nil)
    self.matchesTableView.register(matchCell, forCellReuseIdentifier: "MatchCell")
    self.matchesTableView.dataSource = self
  }
}

extension MatchesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    3
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let matchCell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell

    return matchCell
  }


}
