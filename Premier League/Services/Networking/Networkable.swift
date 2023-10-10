//
//  Networkable.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation

protocol Networkable {
  func fetchData<T: Codable>(url: String, param: [String: Any]?, completionHandler: @escaping (T?) -> Void)
}
