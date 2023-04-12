//
//  SignupModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/09.
//

import Foundation

struct SignupModel: Decodable {
  var status: Int
  var data: CodeData
}
struct CodeData: Decodable {
  var code: String
}

struct CheckingIdModel: Decodable {
  var status: Int
  var data: DuplicatedData
}
struct DuplicatedData: Decodable {
  var isDuplicated: Bool
}

struct SignupUser: Decodable {
  var username: String
}
