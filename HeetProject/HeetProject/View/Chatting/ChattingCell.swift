//
//  ChattingCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//

import UIKit

class ChattingCell: UITableViewCell {
  static let identifier = "ChattingCell"
  private let image: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    return imageview
  }()
  private let username: UILabel = {
    let label = UILabel()
    label.text = "viewer"
    label.font = .systemFont(ofSize: 10)
    label.textColor = .gray
    return label
  }()
  private let message: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    return label
  }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
  func setConstraints() {
    [image, username, message]
      .forEach {
        contentView.addSubview($0)
      }
    image.snp.makeConstraints {
      $0.width.equalTo(30)
      $0.height.equalTo(30)
      $0.leading.equalToSuperview().offset(20)
      $0.top.equalToSuperview().offset(15)
    }
    username.snp.makeConstraints {
      $0.top.equalTo(image.snp.top)
      $0.leading.equalTo(image.snp.trailing).offset(7)
    }
    message.snp.makeConstraints {
      $0.top.equalTo(username.snp.bottom).offset(4)
      $0.leading.equalTo(username.snp.leading)
      $0.trailing.equalToSuperview().offset(-33)
    }
  }
}
