//
//  ShareCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/03.
//

import UIKit

class ShareCell: UITableViewCell {
  static let identifier = "ShareCell"
  var buttonToggle = false
  let cellButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.setTitle("누구와 함께해요!", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    button.backgroundColor = .systemGray
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    return button
  }()
  let cellText: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "ex) 같이 간 사람/ 가고 싶은 사람."
    textfield.font = .systemFont(ofSize: 11)
    return textfield
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  @objc private func didTapButton() {
    if buttonToggle == false {
      cellButton.backgroundColor = ColorManager.BackgroundColor
      buttonToggle = true
    } else {
      cellButton.backgroundColor = .systemGray2
      buttonToggle = false
    }
  }
  func setConstraints() {
    [cellButton, cellText]
      .forEach {
        contentView.addSubview($0)
      }
    cellButton.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.width.equalTo(113)
      $0.height.equalTo(28)
      $0.centerY.equalToSuperview()
    }
    cellText.snp.makeConstraints {
      $0.leading.equalTo(cellButton.snp.trailing).offset(10)
      $0.trailing.equalToSuperview().offset(-20)
      $0.centerY.equalToSuperview()
    }
  }
}
