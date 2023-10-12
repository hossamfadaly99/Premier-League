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
    let matchCell = UINib(nibName: Constants.MATCH_CELL, bundle: nil)
    self.matchesTableView.register(matchCell, forCellReuseIdentifier: Constants.MATCH_CELL)
    self.matchesTableView.dataSource = self
  }

  private func toggleFavoriteValue(with match: MatchModel ) {
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
      button.setImage(UIImage(systemName: Constants.FILTER_TAPPED_ICON), for: .normal)
    } else {
      button.setImage(UIImage(systemName: Constants.FILTER_ICON), for: .normal)
    }
  }
  private func animateButton(_ button: UIButton) {
    UIView.animate(withDuration: 0.3, animations: {
      button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

      button.setImage(UIImage(systemName: Constants.HEART_FILLED_ICON)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
      button.tintColor = .red
    }) { _ in
      UIView.animate(withDuration: 0.3) {
        button.transform = .identity
      }
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
    let matchCell = tableView.dequeueReusableCell(withIdentifier: Constants.MATCH_CELL) as! MatchCell

    if viewModel.isFiltered {
      matchCell.updateUI(match: viewModel.favMatches[indexPath.section][indexPath.row])
    }else {
      matchCell.updateUI(match: viewModel.groupedMatches[indexPath.section][indexPath.row])
    }

    matchCell.dataHandler = { match in
      if !match.isFav {
        self.toggleFavoriteValue(with: match)
        self.animateButton(matchCell.favButton)
      } else {
        Utilities.displayDestructiveAlert(self, title: Constants.REMOVE, text: Constants.REMOVE_FROM_FAV) {
          self.toggleFavoriteValue(with: match)
          matchCell.favButton.setImage(UIImage(systemName: Constants.HEART_ICON)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        }
      }
    }
    return matchCell
  }
}
