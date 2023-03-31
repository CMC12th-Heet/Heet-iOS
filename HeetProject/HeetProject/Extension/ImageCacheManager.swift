//
//  ImageCacheManager.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/13.
//

import UIKit

final class ImageCacheManager {
  static let shared = NSCache<NSString, UIImage>()
  private init() {}
}
