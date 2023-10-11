//
//  ViewController.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import UIKit

class MatchesViewController: UIViewController {

  @IBOutlet weak var matchesTableView: UITableView!
  var viewModel: MatchViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewModel()
    setupTableView()
    viewModel.fetchMatches()
  }

  private func setupViewModel() {
    viewModel = MatchViewModel(networkManager: NetworkManager())
    viewModel.updateViewController = { [weak self] in
      self?.matchesTableView.reloadData()
    }
  }

  private func setupTableView() {
    let matchCell = UINib(nibName: "MatchCell", bundle: nil)
    self.matchesTableView.register(matchCell, forCellReuseIdentifier: "MatchCell")
    self.matchesTableView.dataSource = self
  }
}

extension MatchesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    viewModel.groupedMatches.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.groupedMatches[section].count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    viewModel.groupedMatches[section].first?.date
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let matchCell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell
    print(indexPath)
    matchCell.updateUI(match: viewModel.groupedMatches[indexPath.section][indexPath.row])
    return matchCell
  }
}
