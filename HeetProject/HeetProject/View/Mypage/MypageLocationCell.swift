//
//  MypageLocationCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class MypageLocationCell: UICollectionViewCell {
  static let identifier = "MypageLocationCell"
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "Location"))
    return imageview
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "중구 약수동"
    label.textColor = .white
    return label
  }()
  private let placeImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
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
      $0.edges.equalToSuperview()
      $0.width.equalTo(165)
      $0.height.equalTo(188)
    }
    imageview.snp.makeConstraints {
      $0.width.equalTo(20)
      $0.height.equalTo(25)
      $0.leading.equalToSuperview().offset(10)
      $0.top.equalToSuperview().offset(10)
    }
    label.snp.makeConstraints {
      $0.leading.equalTo(imageview.snp.trailing).offset(10)
      $0.top.equalToSuperview().offset(10)
    }
  }
  
}
