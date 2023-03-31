//
//  UserCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/24.
//
import UIKit

class UserCell: UITableViewCell {
  static let identifier = "UserCell"
  let userview: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    return imageview
  }()
  let label1: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    label.text = "n/a"
    return label
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  func setConstraint() {
    contentView.addSubview(userview)
    userview.addSubview(imageview)
    userview.addSubview(label1)
    userview.snp.makeConstraints {
      $0.width.equalTo(334)
      $0.height.equalTo(44)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
    }
    imageview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.centerY.equalToSuperview()
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    label1.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(imageview.snp.trailing).offset(15)
    }
  }
}
