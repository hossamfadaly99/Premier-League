//
//  NetworkManager.swift
//  Premier League
//
//  Created by Hossam on 10/10/2023.
//

import Foundation
import Alamofire

class NetworkManager: Networkable {
  func fetchData<T>(url: String, param: [String : Any]?, completionHandler: @escaping (T?) -> Void) where T : Codable {
    let header = HTTPHeader(name: "X-Auth-Token", value: "6233929f56b046dbb847b85f7fedbbc8")
    AF.request(url, method: .get, parameters: param, headers: HTTPHeaders(arrayLiteral: header)).responseDecodable(of: T.self) { response in
      switch response.result {
      case .success(let result):
        completionHandler(result)

      case .failure(let error):
        print(error.localizedDescription)
        completionHandler(nil)
      }

    }
  }

  
}
