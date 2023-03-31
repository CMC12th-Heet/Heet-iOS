//
//  LocalCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/27.
//

import UIKit

class LocalCell: UITableViewCell {
  static let identifier = "LocalCell"
  var id = 0
  let lineView: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line1")
    return imageview
  }()
  let title: UILabel = {
    let label = UILabel()
    label.text = "약수 로컬 스콘 맛집"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  let desc: UILabel = {
    let label = UILabel()
    label.text = "삼삼삼베이커리"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 14)
    return label
  }()
  let validImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "localMark"))
    imageView.isHidden = true
    return imageView
  }()
  let localImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "loading"))
    imageView.layer.cornerRadius = 20
    imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  let profileImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "profile"))
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  let nickname: UILabel = {
    let label = UILabel()
    label.text = "heet_member"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    return label
  }()
  @objc func didtapchat() {
  }
  let chatImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "chat"))
    imageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didtapchat)))
    return imageView
  }()
  let scrapImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "scrap"))
    return imageView
  }()
  let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "2분전"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 10, weight: .bold)
    return label
  }()
  let cellview: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 20
    view.layer.borderColor = UIColor.systemGray4.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 17))
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  func setConstraint() {
    contentView.addSubview(cellview)
    [title, desc, validImage, localImage]
      .forEach { cellview.addSubview($0) }
    [lineView, profileImage, nickname, chatImage, scrapImage, timeLabel]
      .forEach { contentView.addSubview($0) }
    localImage.addSubview(button)
    lineView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview()
      $0.height.equalTo(3)
    }
    cellview.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(300)
    }
    title.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(10)
    }
    desc.snp.makeConstraints {
      $0.top.equalTo(title.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
    }
    validImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    localImage.snp.makeConstraints {
      $0.top.equalTo(desc.snp.bottom).offset(10)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(225)
    }
    profileImage.snp.makeConstraints {
      $0.top.equalTo(cellview.snp.bottom).offset(10)
      $0.leading.equalTo(cellview.snp.leading).offset(10)
      $0.width.equalTo(27)
      $0.height.equalTo(27)
    }
    nickname.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.leading.equalTo(profileImage.snp.trailing).offset(7)
    }
    timeLabel.snp.makeConstraints {
      $0.top.equalTo(profileImage.snp.bottom).offset(7)
      $0.leading.equalTo(cellview.snp.leading).offset(10)
    }
    chatImage.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalTo(scrapImage.snp.leading).offset(-22)
      $0.width.equalTo(17)
      $0.height.equalTo(17)
    }
    scrapImage.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalToSuperview().offset(-33)
      $0.width.equalTo(17)
      $0.height.equalTo(17)
    }
    button.setTitle("1/2", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
    button.backgroundColor = .white
    button.layer.cornerRadius = 10
    button.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-10)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }
}
