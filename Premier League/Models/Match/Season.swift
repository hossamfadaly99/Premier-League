//
//  Season.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct Season: Codable {
    let id: Int?
    let startDate, endDate: String?
    let currentMatchday: Int?
}
