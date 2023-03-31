//
//  FollowCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit
import Alamofire

class FollowCell: UITableViewCell {
  static let identifier = "FollowCell"
  var id: Int?
  override func layoutSubviews() {
    super.layoutSubviews()
    contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5.0, left: 0, bottom: 5.0, right: 0))
  }
  private let totalview: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  private let profileImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    imageview.layer.cornerRadius = 15
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  let nickname: UILabel = {
    let label = UILabel()
    label.text = "heet_member"
    return label
  }()
//  let followingButton: UIButton = {
//    let button = UIButton()
//    button.setTitle("팔로우", for: .normal)
//    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
//    button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
//    button.addTarget(self, action: #selector(didTapFollow), for: .touchDown)
//    return button
//  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
//  @objc private func didTapFollow() {
//    AF.request(Resource.baseURL + "/user/follow/\(self.id)",
//               method: .get,
//               parameters: nil,
//               encoding: URLEncoding.queryString,
//               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
//    .validate()
//    .response { response in
//      self.followingButton.titleLabel?.textColor = .gray
//      self.followingButton.setTitleColor(.gray, for: .normal)

  func setConstraint() {
    contentView.addSubview(totalview)
    [profileImage, nickname]
      .forEach {
        totalview.addSubview($0)
      }
    totalview.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(44)
    }
    profileImage.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    nickname.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(profileImage.snp.trailing).offset(10)
    }
//    followingButton.snp.makeConstraints {
//      $0.trailing.equalToSuperview().offset(-20)
//      $0.centerY.equalToSuperview()
//    }
  }
}
