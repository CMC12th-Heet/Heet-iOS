//
//  FaceCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit

class FaceCell: UICollectionViewCell {
  static let identifier = "FaceCell"
  var labeltext = ""
  var imagename = ""
  override var isSelected: Bool {
    didSet {
      if isSelected {
        label.textColor = ColorManager.BackgroundColor
        image.tintColor = ColorManager.BackgroundColor
      } else {
        label.textColor = .black
      }
    }
  }
  let stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .vertical
    stackview.alignment = .center
    stackview.distribution = .equalSpacing
    stackview.spacing = 10
    return stackview
  }()
  lazy var image: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: imagename))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  lazy var label: UILabel = {
    let label = UILabel()
    label.text = labeltext
    label.font = .systemFont(ofSize: 11)
    label.tintColor = .gray
    return label
  }()
  override func prepareForReuse() {
    super.prepareForReuse()
    //    label.textColor = .gray
  }
  func setConstraint() {
    self.contentView.addSubview(stackview)
    stackview.addArrangedSubview(image)
    stackview.addArrangedSubview(label)
    stackview.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    image.snp.makeConstraints {
      $0.width.equalTo(24)
      $0.height.equalTo(24)
    }
  }
}
