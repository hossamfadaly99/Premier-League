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
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    viewModel = MatchViewModel(networkManager: NetworkManager(), dbManager: DBManager(managedContext: (appDelegate?.persistentContainer.viewContext)!))
    viewModel.updateViewController = { [weak self] in
      self?.matchesTableView.reloadData()
    }
  }

  private func setupTableView() {
    let matchCell = UINib(nibName: "MatchCell", bundle: nil)
    self.matchesTableView.register(matchCell, forCellReuseIdentifier: "MatchCell")
    self.matchesTableView.dataSource = self
  }

  private func toggleFavoriteValue(with match: MatchModel) {
    if match.isFav {
      viewModel.removeFavMatches(with: Int32(match.id!))

    } else {
      viewModel.addMatchToFavorites(match: match)
      
    }
    viewModel.fetchMatches()
  }
  @IBAction func didClickFilterButton(_ sender: UIButton) {
    viewModel.isFiltered.toggle()
    self.matchesTableView.reloadData()
    self.configureFilterUI(sender)

  }

  private func configureFilterUI(_ button: UIButton) {
    if viewModel.isFiltered {
      button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle.fill"), for: .normal)
    } else {
      button.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
    }
  }
}

extension MatchesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    if viewModel.isFiltered {
      return viewModel.favMatches.count
    }else {
      return viewModel.groupedMatches.count
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if viewModel.isFiltered {
      return viewModel.favMatches[section].count
    }else {
      return viewModel.groupedMatches[section].count
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if viewModel.isFiltered {
      return viewModel.favMatches[section].first?.date
    }else {
      return viewModel.groupedMatches[section].first?.date
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let matchCell = tableView.dequeueReusableCell(withIdentifier: "MatchCell") as! MatchCell

    if viewModel.isFiltered {
      matchCell.updateUI(match: viewModel.favMatches[indexPath.section][indexPath.row])
    }else {
      matchCell.updateUI(match: viewModel.groupedMatches[indexPath.section][indexPath.row])
    }

    matchCell.dataHandler = { id in
      self.toggleFavoriteValue(with: id)
    }
    return matchCell
  }
}
