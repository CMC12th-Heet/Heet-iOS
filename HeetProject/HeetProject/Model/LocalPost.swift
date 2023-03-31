//
//  LocalPost.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/13.
//

import Foundation

struct Post: Decodable {
  var posts: [LocalPost]?
}
struct LocalPost: Decodable {
  var post_id: Int?
  var title: String?
  var mini_title: String?
  var content: String?
  var file_url: String?
  var satisfaction: Int?
  var together_with: String?
  var perfect_day: String?
  var moving_tip: String?
  var ordering_tip: String?
  var other_tips: String?
  var is_local: Bool?
  var created_at: String?
  var user: User?
  var store: Store?
  var isMyPost: Int?
  var urlList: [String]?
}
