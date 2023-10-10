//
//  Competesion.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

struct Competition: Codable {
    let id: Int?
    let area: Area?
    let name, code, plan: String?
    let lastUpdated: String?
}
