//
//  FollowingModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/23.
//

import Foundation

struct FollowingModel: Decodable {
  var following: [Following]
}
struct Following: Decodable {
  var user_id: Int
  var email: String
  var username: String
  var password: String
  var is_verify: Bool
  var town: String
  var status: Bool
}
