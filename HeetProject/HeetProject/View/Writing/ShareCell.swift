//
//  ShareCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/03.
//

import UIKit

var cellText1: String?
var cellText2: String?
var cellText3: String?
var cellText4: String?
var cellText5: String?
class ShareCell: UITableViewCell {
  static let identifier = "ShareCell"
  var cellIndex = 0
  var buttonToggle = false
  let cellButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 15
    button.setTitle("누구와 함께해요!", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
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
    cellText.delegate = self
  }
  override func prepareForReuse() {
    super.prepareForReuse()
    cellText.text = ""
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    cellText.delegate = self
  }
  @objc private func didTapButton() {
    if buttonToggle == false {
      cellButton.backgroundColor = ColorManager.BackgroundColor
      buttonToggle = true
    } else {
      cellButton.backgroundColor = .systemGray
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
extension ShareCell: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    switch cellIndex {
    case 1: cellText1 = textField.text ?? ""
      print("hhh")
    case 2: cellText2 = textField.text ?? ""
      print("aaa")
    case 3: cellText3 = textField.text ?? ""
    case 4: cellText4 = textField.text ?? ""
    case 5: cellText5 = textField.text ?? ""
    default: break
    }
    print("hhhh")
  }
}
