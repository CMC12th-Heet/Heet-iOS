//
//  ScrapCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/25.

import UIKit

class ScrapCell: UICollectionViewCell {
  static let identifier = "ScrapCell"
  var scrap: LocalPost?
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "wlocation"))
    return imageview
  }()
  var label: UILabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = .white
    return label
  }()
  var placeImage: UIImageView = {
    let imageview = UIImageView()
    imageview.contentMode = .scaleAspectFill
    imageview.clipsToBounds = true
    imageview.layer.cornerRadius = 10
    return imageview
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  func setConstraint() {
    contentView.addSubview(placeImage)
    placeImage.addSubview(imageview)
    placeImage.addSubview(label)
    placeImage.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    imageview.snp.makeConstraints {
      $0.width.equalTo(15)
      $0.height.equalTo(20)
      $0.leading.equalToSuperview().offset(10)
      $0.top.equalToSuperview().offset(10)
    }
    label.snp.makeConstraints {
      $0.leading.equalTo(imageview.snp.trailing).offset(10)
      $0.top.equalToSuperview().offset(10)
    }
  }
}
