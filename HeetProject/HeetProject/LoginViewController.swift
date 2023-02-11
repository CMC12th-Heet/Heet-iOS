//
//  ViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/10.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
  private let logoImage = {
    let imageView = UIImageView(image: UIImage(named: "LoginLogo"))
    imageView.widthAnchor.constraint(equalToConstant: 100)
    imageView.heightAnchor.constraint(equalToConstant: 100)
    return imageView
  }()
  private let emailTextField = {
    let textField = UITextField()
    textField.placeholder = "아이디 또는 이메일 입력"
    textField.layer.cornerRadius = 25
    textField.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    textField.layer.borderWidth = 0.6
    return textField
  }()
  let passwordTextField = {
    let textField = UITextField()
    textField.placeholder = "비밀번호 입력"
    textField.layer.cornerRadius = 25
    textField.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    textField.layer.borderWidth = 0.6
    return textField
  }()
  let emailAlertLabel = {
    let label = UILabel()
    label.textColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 이메일입니다."
    return label
  }()
  let passwordAlertLabel = {
    let label = UILabel()
    label.textColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 비밀번호입니다."
    return label
  }()
  let loginButton = {
    let button = UIButton()
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitle("로그인", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 25
    return button
  }()
  let findPasswordButton = {
    let button = UIButton()
    button.setTitle("비밀번호 찾기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    return button
  }()
  let gotoSignupButton = {
    let button = UIButton()
    button.setTitle("회원가입 하기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    return button
  }()
  let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 8
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureUI()
  }
  private func configureUI() {
    [logoImage, emailTextField, passwordTextField, emailAlertLabel, passwordAlertLabel, loginButton, stackView]
      .forEach { view.addSubview($0) }
    stackView.addArrangedSubview(findPasswordButton)
    stackView.addArrangedSubview(gotoSignupButton)
    logoImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
    }
    emailTextField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
      $0.width.equalTo(300)
      $0.height.equalTo(50)
    }
    emailAlertLabel.snp.makeConstraints {
      $0.left.equalTo(emailTextField.snp.left).offset(10)
      $0.top.equalTo(emailTextField.snp.bottom).offset(5)
    }
    passwordTextField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(emailAlertLabel.snp.bottom).offset(20)
      $0.width.equalTo(300)
      $0.height.equalTo(50)
    }
    passwordAlertLabel.snp.makeConstraints {
      $0.left.equalTo(passwordTextField.snp.left).offset(10)
      $0.top.equalTo(passwordTextField.snp.bottom).offset(5)
    }
    loginButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(passwordTextField.snp.bottom).offset(80)
      $0.width.equalTo(300)
      $0.height.equalTo(50)
    }
    stackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(loginButton.snp.bottom)
    }
  }
}
