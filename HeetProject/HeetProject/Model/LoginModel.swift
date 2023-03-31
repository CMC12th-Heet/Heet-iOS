//
//  LoginModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/10.
//

import Foundation

struct LoginModel: Decodable {
  var message: String
  var token: String
  var town: String
}
