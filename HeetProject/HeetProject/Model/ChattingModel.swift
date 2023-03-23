//
//  ChattingModel.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/19.
//

import Foundation

struct ChattingModel: Decodable {
  var comment_id: Int?
  var content: String?
  var created_at: String?
  var user: User?
}
