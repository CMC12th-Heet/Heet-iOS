//
//  Store.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/31.
//

import Foundation

struct Store: Decodable {
  var store_id: Int
  var name: String
  var url: String
  var address: String
}
