//
//  SignupIdViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/12.
//

import UIKit
import SnapKit

class SignupIdViewController: UIViewController {
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일"
    label.textColor = .gray
    return label
  }()
  private let emailtextLabel = {
    let label = UILabel()
    label.text = "jenny0810@naver.com"
    label.textColor = .gray
    return label
  }()
  private let lineView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let passwordLabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.textColor = .gray
    return label
  }()
  private let passwordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = ""
    return textField
  }()
  private let passwordLineView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let rePasswordLabel = {
    let label = UILabel()
    label.text = "아이디를 설정하세요"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let rePasswordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "dfdfer"
    return textField
  }()
  private let doubleCheckButton = {
    let button = UIButton()
    button.setTitle("중복 확인", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 10
    button.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(didTapCheck), for: .allTouchEvents)
    return button
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureUI()
  }
  @objc private func didTapCheck() {
    
  }
  private func configureUI() {
    [emailLabel, emailtextLabel, passwordTextfield, passwordLabel, passwordLineView, lineView, repasswordLineView, rePasswordLabel, rePasswordTextfield, doubleCheckButton]
      .forEach { view.addSubview($0) }
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
      $0.left.equalToSuperview().offset(30)
    }
    emailtextLabel.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    lineView.snp.makeConstraints {
      $0.top.equalTo(emailtextLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(5)
    }
    passwordLabel.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(50)
      $0.left.equalTo(emailLabel.snp.left)
    }
    passwordTextfield.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    passwordLineView.snp.makeConstraints {
      $0.top.equalTo(passwordTextfield.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(5)
    }
    rePasswordLabel.snp.makeConstraints {
      $0.top.equalTo(passwordLineView.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    rePasswordTextfield.snp.makeConstraints {
      $0.top.equalTo(rePasswordLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    repasswordLineView.snp.makeConstraints {
      $0.top.equalTo(rePasswordTextfield.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(5)
    }
    doubleCheckButton.snp.makeConstraints {
      $0.width.equalTo(100)
      $0.height.equalTo(30)
      $0.right.equalTo(repasswordLineView.snp.right).offset(20)
      $0.bottom.equalTo(rePasswordTextfield.snp.bottom)
    }
  }
}
