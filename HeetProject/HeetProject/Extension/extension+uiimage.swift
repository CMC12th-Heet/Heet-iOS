//
//  extension+uiimage.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/27.
//

import UIKit

extension UIImage {
  func resizeWithWidth(width: CGFloat) -> UIImage? {
    let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 268)))
    imageView.contentMode = .scaleAspectFit
    imageView.image = self
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    imageView.layer.render(in: context)
    guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    UIGraphicsEndImageContext()
    return result
  }
}
