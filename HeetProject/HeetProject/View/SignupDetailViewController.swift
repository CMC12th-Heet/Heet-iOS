//
//  SignupDetailViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/11.
//

import UIKit
import SnapKit

final class SignupDetailViewController: UIViewController {
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
    label.text = "비밀번호를 설정하세요"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let passwordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "숫자/영문/특수문자 중 두가지 이상, 8자~32자"
    return textField
  }()
  private let passwordLineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let rePasswordLabel = {
    let label = UILabel()
    label.text = "비밀번호 재확인"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let rePasswordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "재확인"
    return textField
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let numberImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let numberCheck = {
    let label = UILabel()
    label.text = "숫자"
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let englishImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let englishCheck = {
    let label = UILabel()
    label.text = "영문"
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let specialImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let specialCheck = {
    let label = UILabel()
    label.text = "특수문자"
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let countImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let countCheck = {
    let label = UILabel()
    label.text = "8자 이상"
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let nextButton = {
    let button = UIButton()
    button.setTitle("다음", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.backgroundColor = .gray
    button.addTarget(self, action: #selector(didTapNext), for: .allTouchEvents)
    return button
  }()
  @objc private func didTapNext() {
    self.navigationController?.pushViewController(SignupIdViewController(), animated: false)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    passwordTextfield.delegate = self
    configureUI()
  }
  private func configureUI() {
    [emailLabel, emailtextLabel, lineView, passwordLabel, passwordTextfield, passwordLineView, rePasswordLabel, rePasswordTextfield, repasswordLineView, numberCheck, numberImage, englishCheck, englishImage, specialCheck, specialImage, countCheck, countImage, nextButton]
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
      $0.top.equalTo(countCheck.snp.bottom).offset(20)
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
    numberImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left)
      $0.top.equalTo(passwordLineView.snp.bottom).offset(20)
    }
    numberCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.left)
      $0.top.equalTo(passwordLineView.snp.bottom).offset(20)
    }
    englishImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left)
      $0.top.equalTo(numberCheck.snp.bottom).offset(20)
    }
    englishCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.left)
      $0.top.equalTo(numberCheck.snp.bottom).offset(20)
    }
    specialImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left)
      $0.top.equalTo(englishCheck.snp.bottom).offset(20)
    }
    specialCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.left)
      $0.top.equalTo(englishCheck.snp.bottom).offset(20)
    }
    countImage.snp.makeConstraints {
      $0.left.equalTo(emailLabel.snp.left)
      $0.top.equalTo(specialCheck.snp.bottom).offset(20)
    }
    countCheck.snp.makeConstraints {
      $0.left.equalTo(numberImage.snp.left)
      $0.top.equalTo(specialCheck.snp.bottom).offset(20)
    }
    nextButton.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
      $0.width.equalTo(100)
      $0.height.equalTo(50)
    }
  }
}
extension SignupDetailViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    for i in [specialImage, specialCheck, englishImage, englishCheck, numberCheck, numberImage, countCheck, countImage] {
      i.isHidden = false
    }
//    for i in [repasswordLineView, rePasswordLabel, rePasswordTextfield] {
//      i.isHidden = true
//    }
//    rePasswordLabel.snp.makeConstraints {
//      $0.top.equalTo(countCheck.snp.bottom).offset(20)
//    }
//    rePasswordLabel.isHidden = false
  }
}
