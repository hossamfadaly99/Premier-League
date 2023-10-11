//
//  Utilities.swift
//  Premier League
//
//  Created by Hossam on 11/10/2023.
//

import Foundation

class Utilities {
  static func convertUTCtoHHMM(_ utcString: String?) -> String? {
    guard let utcString = utcString else { return nil }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    if let date = dateFormatter.date(from: utcString) {
      dateFormatter.dateFormat = "HH:mm"
      dateFormatter.timeZone = TimeZone(identifier: "Africa/Cairo")

      let hhmmString = dateFormatter.string(from: date)
      return hhmmString
    }
    return nil
  }
  static func convertUTCtoYYYYMMDD(_ utcString: String?) -> String? {
    guard let utcString = utcString else { return nil }

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")

    if let date = dateFormatter.date(from: utcString) {
      dateFormatter.dateFormat = "YYYY-MM-dd"
      dateFormatter.timeZone = TimeZone(identifier: "Africa/Cairo")

      let ymdString = dateFormatter.string(from: date)
      return ymdString
    }
    return nil
  }

  static func getcurrentDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.timeZone = TimeZone(identifier: "Africa/Cairo")

    let currentDateInCairo = Date()

    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let currentDateInUTC = dateFormatter.string(from: currentDateInCairo)

    return currentDateInUTC
  }

  static func getNextYearDate() -> String {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "Africa/Cairo")

        let currentDateInCairo = Date()

        if let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: currentDateInCairo) {
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            let currentDateInUTC = dateFormatter.string(from: oneYearLater)
            return currentDateInUTC
        } else {
            return "Date calculation error"
        }
  }

}
