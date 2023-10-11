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

    let entity = NSEntityDescription.entity(forEntityName: "MatchSummary", in: managedContext)!
    let matchSummary = MatchSummary(entity: entity, insertInto: managedContext)
    
    matchSummary.id = Int32(match.id ?? 0)
    matchSummary.awayTeam = match.awayTeam
    matchSummary.date = match.date
    matchSummary.homeTeam = match.homeTeam
    matchSummary.info = match.info
    matchSummary.matchDay = match.matchDay
    matchSummary.status = match.status
    matchSummary.homeScore = Int32(match.homeScore ?? 0)
    matchSummary.awayScore = Int32(match.awayScore ?? 0)

    try? managedContext.save()
  }

  func removeFavMatches(_ match: MatchModel) {
    let fetchRequest: NSFetchRequest<MatchSummary> = MatchSummary.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == %d", Int32(match.id ?? 0))

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

  func getFavoriteMatches() -> [MatchModel] {
    let request: NSFetchRequest<MatchSummary> = MatchSummary.fetchRequest()
    var matches: [MatchModel] = []
    do {
      let results = try managedContext.fetch(request)
      matches = []
      for matchSummary in results {
        matches.append(MatchModel(id: Int(matchSummary.id), status: matchSummary.status, homeTeam: matchSummary.homeTeam, awayTeam: matchSummary.awayTeam, info: matchSummary.info, matchDay: matchSummary.matchDay, date: matchSummary.date, homeScore: Int(matchSummary.homeScore), awayScore: Int(matchSummary.awayScore)))
      }
    } catch let error as NSError {
      print("Could not fetch \(error), \(error.userInfo)")
    }
    return matches
  }

}
