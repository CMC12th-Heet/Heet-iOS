//
//  MypageModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/11.
//

import Foundation

struct MypageModel: Decodable {
  var user_id: Int
  var email: String
  var username: String
  var password: String
  var is_verify: Bool
  var town: String
  var status: String?
  var post: [LocalPost]?
}
