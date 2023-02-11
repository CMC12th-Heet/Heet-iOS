//
//  SignupViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/11.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
  private let emailTextField = {
    let textField = UITextField()
    textField.placeholder = "이메일 입력"
    textField.layer.cornerRadius = 25
    textField.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    textField.layer.borderWidth = 0.6
    return textField
  }()
  private let validateButton = {
    let button = UIButton()
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitle("이메일 인증하기", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 25
    button.addTarget(self, action: #selector(didTapValidate), for: .allTouchEvents)
    return button
  }()
  private let emailImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.widthAnchor.constraint(equalToConstant: 20)
    imageView.heightAnchor.constraint(equalToConstant: 20)
    imageView.isHidden = true
    return imageView
  }()
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일 전송이 성공되었습니다.\n인증 코드 6자리를 입력해주세요."
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let validateNumber = {
    let textField = UITextField()
    textField.placeholder = "인증코드 입력"
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    return textField
  }()
  private let validateNumberButton = {
    let button = UIButton()
    button.setTitle("인증 요청", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 1
    button.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    button.addTarget(self, action: #selector(didTapValidateNumber), for: .allTouchEvents)
    return button
  }()
  private let lineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let requestLabel = {
    let label = UILabel()
    label.text = "인증번호를 받지 못하셨나요?"
    label.textColor = .gray
    return label
  }()
  private let requestButton = {
    let button = UIButton()
    button.setTitle("재전송하기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    return button
  }()
  private let nextButton = {
    let button = UIButton()
    button.setTitle("다음", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.tintColor = ColorManager.BackgroundColor
    button.semanticContentAttribute = .forceRightToLeft
    button.addTarget(self, action: #selector(didTapNext), for: .allTouchEvents)
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureUI()
    self.navigationController?.title = "회원 가입"
  }
  private func configureUI() {
    [emailTextField, validateButton, emailImage, emailLabel, validateNumber, validateNumberButton, lineView, requestButton, requestLabel, nextButton]
      .forEach { view.addSubview($0) }
    emailTextField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
      $0.width.equalTo(350)
      $0.height.equalTo(50)
    }
    validateButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(emailTextField.snp.bottom).offset(20)
      $0.width.equalTo(350)
      $0.height.equalTo(50)
    }
    emailImage.snp.makeConstraints {
      $0.left.equalTo(validateButton.snp.left)
      $0.top.equalTo(validateButton.snp.bottom).offset(20)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    emailLabel.snp.makeConstraints {
      $0.left.equalTo(emailImage.snp.right).offset(20)
      $0.top.equalTo(emailImage.snp.top)
    }
    validateNumber.snp.makeConstraints {
      $0.left.equalTo(emailImage.snp.left)
      $0.top.equalTo(emailImage.snp.bottom).offset(50)
    }
    lineView.snp.makeConstraints {
      $0.top.equalTo(validateNumber.snp.bottom).offset(30)
      $0.left.equalTo(validateButton.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(1)
    }
    validateNumberButton.snp.makeConstraints {
      $0.top.equalTo(validateNumber.snp.top)
      $0.right.equalTo(lineView.snp.right)
      $0.width.equalTo(120)
      $0.height.equalTo(50)
    }
    requestLabel.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(40)
      $0.left.equalTo(lineView.snp.left).offset(20)
    }
    requestButton.snp.makeConstraints {
      $0.right.equalTo(lineView.snp.right)
      $0.top.equalTo(requestLabel.snp.top)
    }
    nextButton.snp.makeConstraints {
      $0.top.equalTo(requestButton.snp.bottom).offset(100)
      $0.right.equalTo(lineView.snp.right)
    }
  }
  @objc private func didTapValidate() {
    emailLabel.isHidden = false
    emailImage.isHidden = false
  }
  @objc private func didTapValidateNumber() {
    
  }
  @objc private func didTapNext() {
    self.navigationController?.pushViewController(SignupDetailViewController(), animated: false)
  }
}
