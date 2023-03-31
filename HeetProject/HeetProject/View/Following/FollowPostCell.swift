//
//  FollowPostCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class FollowPostCell: UITableViewCell {
  static let identifier = "FollowPostCell"
  var postModel: LocalPost?
  private let totalview: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 15
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  private let profileImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  private let nickname: UILabel = {
    let label = UILabel()
    label.text = "heet_ios"
    label.textColor = .gray
    return label
  }()
  private let location: UILabel = {
    let label = UILabel()
    label.text = "카페 704"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  let locationImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "Location"))
    imageView.clipsToBounds = true
    return imageView
  }()
  let imageview: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "follow"))
    imageView.clipsToBounds = true
    return imageView
  }()
  let scrapImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "scrap"))
    return imageView
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    location.text = postModel?.store?.name
    nickname.text = postModel?.user?.username
  }
  func setConstraint() {
    contentView.addSubview(totalview)
    totalview.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.bottom.equalToSuperview().offset(-10)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(281)
    }
    [profileImage, location, nickname, locationImage, imageview]
      .forEach {
        totalview.addSubview($0)
      }
    profileImage.snp.makeConstraints {
      $0.leading.equalTo(totalview.snp.leading).offset(10)
      $0.top.equalTo(totalview.snp.top).offset(10)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    nickname.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.leading.equalTo(profileImage.snp.trailing).offset(10)
    }
    locationImage.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalTo(totalview.snp.trailing).offset(-10)
    }
    location.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalTo(locationImage.snp.leading).offset(-10)
    }
    imageview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(10)
    }
  }
}
