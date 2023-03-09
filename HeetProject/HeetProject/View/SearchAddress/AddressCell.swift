//
//  AddressCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit

class AddressCell: UITableViewCell {
  static let identifier = "AddressCell"
  let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "Location"))
    return imageview
  }()
  let label1: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .gray
    label.text = "where am I"
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    label.textColor = .systemGray4
    label.text = "whererere"
    return label
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    if selected {
      label1.textColor = ColorManager.BackgroundColor
    } else {
      label1.textColor = .gray
    }
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    label1.textColor = .gray
  }
  func setConstraint() {
    [imageview, label1, label2]
      .forEach {
        contentView.addSubview($0)
      }
    imageview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.top.equalToSuperview().offset(17)
      $0.width.equalTo(17)
      $0.height.equalTo(20)
    }
    label1.snp.makeConstraints {
      $0.leading.equalTo(imageview.snp.trailing).offset(8)
      $0.top.equalToSuperview().offset(17)
    }
    label2.snp.makeConstraints {
      $0.top.equalTo(label1.snp.bottom).offset(5)
      $0.leading.equalTo(label1.snp.leading)
    }
  }
}
