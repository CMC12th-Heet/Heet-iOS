//
//  Resource.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/10.
//

import Foundation
import Alamofire

struct Resource {
  static let baseURL: String = "http://13.209.43.219:3000"
  static let header: HTTPHeaders = [
    "Content-Type": "application/json",
    "Authorization": UserDefaults.standard.string(forKey: "loginToken") ?? ""
  ]
}
