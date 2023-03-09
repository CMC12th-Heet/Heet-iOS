//
//  TagLabelCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/08.
//

import UIKit

class TagLabelCell: UICollectionViewCell {
  static let identifier = "TagLabelCell"
  private let textfield: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "# 태그하기"
    return textfield
  }()
  func setConstraint() {
    contentView.addSubview(textfield)
    textfield.snp.makeConstraints {
      $0.edges.equalToSuperview().offset(10)
    }
  }
}
