//
//  DatabaseManager.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation
import CoreData

class DBManager: Cachable {
  var managedContext: NSManagedObjectContext!

  init(managedContext: NSManagedObjectContext) {
    self.managedContext = managedContext
  }

  func insertMatch(_ match: MatchModel) {

    let entity = NSEntityDescription.entity(forEntityName: Constants.Fav_Match_ENTITY, in: managedContext)!
    let favoriteMatch = FavoriteMatch(entity: entity, insertInto: managedContext)
    favoriteMatch.id = Int32(match.id ?? 0)

    try? managedContext.save()
  }

  func removeFavMatche(with id: Int32) {
    let fetchRequest: NSFetchRequest<FavoriteMatch> = FavoriteMatch.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id == %d", id)

    do {
      let matches = try managedContext.fetch(fetchRequest)

      if let matchSummary = matches.first {
        managedContext.delete(matchSummary)

        do {
          try managedContext.save()
        } catch {
          print("Error deleting item: \(error)")
        }
      }
    } catch {
      print("Error fetching item to delete: \(error)")
    }

  }

  func getFavoriteMatches() -> [Int] {
    let request: NSFetchRequest<FavoriteMatch> = FavoriteMatch.fetchRequest()
    var idList: [Int] = []
    do {
      let results = try managedContext.fetch(request)
      idList = []
      for matchSummary in results {
        idList.append(Int(matchSummary.id))
      }
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
    return idList
  }

}
