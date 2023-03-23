//
//  SignupDetailViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/11.
//

import UIKit
import SnapKit

final class SignupDetailViewController: UIViewController {
  var password: String?
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일"
    label.textColor = .gray
    return label
  }()
  let emailtextLabel = {
    let label = UILabel()
    label.textColor = .systemGray4
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return label
  }()
  private let passwordLabel = {
    let label = UILabel()
    label.text = "비밀번호를 설정하세요*"
    label.font = .systemFont(ofSize: 17)
    label.textColor = .gray
    return label
  }()
  private let passwordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.font = .systemFont(ofSize: 15)
    textField.placeholder = "숫자/영문/특수문자 중 두가지 이상, 8자~32자"
    return textField
  }()
  private let passwordLineView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  private let rePasswordLabel = {
    let label = UILabel()
    label.text = "비밀번호 재확인"
    label.font = .systemFont(ofSize: 17)
    label.textColor = .gray
    return label
  }()
  private let rePasswordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "재확인"
    textField.font = .systemFont(ofSize: 15)
    return textField
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  private let numberImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let numberCheck = {
    let label = UILabel()
    label.text = "숫자"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    label.isHidden = true
    return label
  }()
  private let englishImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let englishCheck = {
    let label = UILabel()
    label.text = "영문"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    label.isHidden = true
    return label
  }()
  private let specialImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let specialCheck = {
    let label = UILabel()
    label.text = "특수문자"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let countImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let countCheck = {
    let label = UILabel()
    label.text = "8자 이상"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    label.isHidden = true
    return label
  }()
  private let reImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let reCheck = {
    let label = UILabel()
    label.text = "일치합니다."
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    label.isHidden = true
    return label
  }()
  @objc private func didTapNext() {
    let vc = SignupIdViewController()
    vc.emailtextLabel.text = emailtextLabel.text
    vc.sendPassword = self.password ?? ""
    self.navigationController?.pushViewController(vc, animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.topItem?.backBarButtonItem = nil
    //    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(didTapNext))
    self.view.backgroundColor = .white
    passwordTextfield.delegate = self
    rePasswordTextfield.delegate = self
    self.navigationItem.title = "회원 가입"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    self.navigationController?.navigationBar.topItem?.titleView?.tintColor = ColorManager.BackgroundColor
    configureUI()
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  private func configureUI() {
    [emailLabel, emailtextLabel, passwordLabel, passwordTextfield, passwordLineView, rePasswordLabel, rePasswordTextfield, repasswordLineView, numberCheck, numberImage, englishCheck, englishImage, specialCheck, specialImage, countCheck, countImage, reImage, reCheck]
      .forEach { view.addSubview($0) }
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
      $0.left.equalToSuperview().offset(30)
    }
    emailtextLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
      $0.trailing.equalToSuperview().offset(-20)
    }
    passwordLabel.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(50)
      $0.left.equalTo(emailLabel.snp.left)
    }
    passwordTextfield.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    passwordLineView.snp.makeConstraints {
      $0.top.equalTo(passwordTextfield.snp.bottom).offset(15)
      $0.left.equalTo(emailLabel.snp.left)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(3)
    }
    rePasswordLabel.snp.makeConstraints {
      $0.top.equalTo(countCheck.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
    }
    rePasswordTextfield.snp.makeConstraints {
      $0.top.equalTo(rePasswordLabel.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(200)
    }
    repasswordLineView.snp.makeConstraints {
      $0.top.equalTo(rePasswordTextfield.snp.bottom).offset(20)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(3)
    }
    numberImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left).offset(10)
      $0.top.equalTo(passwordLineView.snp.bottom).offset(10)
    }
    numberCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.right).offset(10)
      $0.top.equalTo(passwordLineView.snp.bottom).offset(10)
    }
    englishImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left).offset(10)
      $0.top.equalTo(numberCheck.snp.bottom).offset(10)
    }
    englishCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.right).offset(10)
      $0.top.equalTo(numberCheck.snp.bottom).offset(10)
    }
    specialImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left).offset(10)
      $0.top.equalTo(englishCheck.snp.bottom).offset(10)
    }
    specialCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.right).offset(10)
      $0.top.equalTo(englishCheck.snp.bottom).offset(10)
    }
    countImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left).offset(10)
      $0.top.equalTo(specialCheck.snp.bottom).offset(10)
    }
    countCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.right).offset(10)
      $0.top.equalTo(specialCheck.snp.bottom).offset(10)
    }
    reImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left).offset(10)
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(10)
    }
    reCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.right).offset(10)
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(10)
    }
  }
}
extension SignupDetailViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    passwordTextfield.isSecureTextEntry = true
    rePasswordTextfield.isSecureTextEntry = true
    for i in [specialImage, specialCheck, englishImage, englishCheck, numberCheck, numberImage, countCheck, countImage, reImage, reCheck] {
      i.isHidden = false
    }
    password = passwordTextfield.text
    let numberRegex = "[0-9]"
    if password?.range(of: numberRegex, options: .regularExpression) != nil {
      numberImage.image = UIImage(named: "checkedImage")
    } else {
      numberImage.image = UIImage(named: "uncheckedImage")
    }
    let englishRegex = "[a-zA-Z]"
    if password?.range(of: englishRegex, options: .regularExpression) != nil {
      englishImage.image = UIImage(named: "checkedImage")
    } else {
      englishImage.image = UIImage(named: "uncheckedImage")
    }
    let specialRegex = "[~!@#$%^&*]"
    if password?.range(of: specialRegex, options: .regularExpression) != nil {
      specialImage.image = UIImage(named: "checkedImage")
    } else {
      specialImage.image = UIImage(named: "uncheckedImage")
    }
    if password!.count >= 8 {
      countImage.image = UIImage(named: "checkedImage")
    } else {
      countImage.image = UIImage(named: "uncheckedImage")
    }
    if !(password?.isEmpty ?? true) && password == rePasswordTextfield.text {
      reCheck.isHidden = false
      reImage.isHidden = false
      reImage.image = UIImage(named: "checkedImage")
      password = rePasswordTextfield.text
    } else {
      reCheck.isHidden = true
      reImage.isHidden = true
      reImage.image = UIImage(named: "checkedImage")
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(didTapNext))
    }
  }
}
