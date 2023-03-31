//
//  SignupModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/09.
//

import Foundation

struct SignupModel: Decodable {
  var code: String
}
struct CheckingIdModel: Decodable {
  var isDuplicated: Bool
}
struct SignupUser: Decodable {
  var username: String
}
