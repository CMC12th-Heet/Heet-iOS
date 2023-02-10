//
//  ViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/10.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
  var logoImage = {
    let imageView = UIImageView(image: UIImage(named: "LoginLogoImage"))
    return imageView
  }()
  var emailTextField = {
    let textField = UITextField()
    textField.placeholder = "아이디 또는 이메일 입력"
    return textField
  }()
  var passwordTextField = {
    let textField = UITextField()
    textField.placeholder = "비밀번호 입력"
    return textField
  }()
  var emailAlertLabel = {
    let label = UILabel()
    label.tintColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 이메일입니다."
    return label
  }()
  var passwordAlertLabel = {
    let label = UILabel()
    label.tintColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 비밀번호입니다."
    return label
  }()
  var loginButton = {
    let button = UIButton()
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitle("로그인", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 20
    return button
  }()
  var findPasswordButton = {
    let button = UIButton()
    button.setTitle("비밀번호 찾기", for: .normal)
    button.tintColor = .gray
  }()
  var gotoSignupButton = {
    let button = UIButton()
    button.setTitle("회원가입 하기", for: .normal)
    button.tintColor = .gray
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
