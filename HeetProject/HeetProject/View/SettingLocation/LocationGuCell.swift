//
//  FaceCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit
import SnapKit

class LocationGuCell: UICollectionViewCell {
  static let identifier = "LocationGuCell"
  var labeltext = ""
  lazy var label: UILabel = {
    let label = UILabel()
    label.text = labeltext
    label.font = .systemFont(ofSize: 16)
    label.tintColor = .gray
    return label
  }()
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  func setConstraint() {
    contentView.addSubview(label)
    label.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
  }
}
