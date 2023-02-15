//
//  SignupViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/11.
//

import UIKit
import SnapKit

class SignupViewController: UIViewController {
  var emailText: String?
  var timeSet: Int = 180
  var timer: Timer?
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
    button.addTarget(self, action: #selector(didTapValidate), for: .touchDown)
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
    label.text = "이메일 전송이 성공되었습니다."
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let emailLabel2 = {
    let label = UILabel()
    label.text = "인증 코드 6자리를 입력해주세요."
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
  private let timeLabel = {
    let label = UILabel()
    label.text = "03:00"
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let validateNumberButton = {
    let button = UIButton()
    button.setTitle("인증 요청", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 1
    button.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    button.addTarget(SignupViewController.self, action: #selector(didTapValidateNumber), for: .touchDown)
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
    label.isHidden = true
    return label
  }()
  private let requestButton = {
    let button = UIButton()
    button.setTitle("재전송하기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.isHidden = true
    button.addTarget(self, action: #selector(didTapReValidate), for: .touchDown)
    return button
  }()
  private let nextButton = {
    let button = UIButton()
    button.setTitle("다음", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.tintColor = ColorManager.BackgroundColor
    button.semanticContentAttribute = .forceRightToLeft
    button.addTarget(self, action: #selector(didTapNext), for: .touchDown)
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    emailTextField.delegate = self
    configureUI()
    self.navigationItem.title = "회원 가입"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
  }
  private func configureUI() {
    [emailTextField, validateButton, emailImage, emailLabel, validateNumber, validateNumberButton, lineView, requestButton, requestLabel, nextButton, emailLabel2, timeLabel]
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
    emailLabel2.snp.makeConstraints {
      $0.left.equalTo(emailImage.snp.right).offset(20)
      $0.top.equalTo(emailLabel.snp.bottom).offset(2)
    }
    validateNumber.snp.makeConstraints {
      $0.left.equalTo(emailImage.snp.left)
      $0.top.equalTo(emailImage.snp.bottom).offset(50)
    }
    lineView.snp.makeConstraints {
      $0.top.equalTo(validateNumber.snp.bottom).offset(10)
      $0.left.equalTo(validateButton.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(1)
    }
    validateNumberButton.snp.makeConstraints {
      $0.bottom.equalTo(lineView.snp.top).offset(-10)
      $0.right.equalTo(lineView.snp.right)
      $0.width.equalTo(120)
      $0.height.equalTo(50)
    }
    requestLabel.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(20)
      $0.left.equalTo(lineView.snp.left).offset(20)
    }
    requestButton.snp.makeConstraints {
      $0.right.equalTo(lineView.snp.right).offset(-10)
      $0.centerY.equalTo(requestLabel.snp.centerY)
    }
    nextButton.snp.makeConstraints {
      $0.top.equalTo(requestButton.snp.bottom).offset(100)
      $0.right.equalTo(lineView.snp.right)
    }
    timeLabel.snp.makeConstraints {
      $0.trailing.equalTo(requestButton.snp.leading).offset(10)
      $0.centerY.equalTo(validateNumber.snp.centerY)
    }
  }
  @objc private func didTapValidate() {
    emailLabel.isHidden = false
    emailImage.isHidden = false
    validateButton.isUserInteractionEnabled = false
    validateButton.backgroundColor = .gray
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      self.timeSet -= 1
      var minute = self.timeSet / 60
      var seconds = self.timeSet % 60
      if self.timeSet > 0 {
        self.timeLabel.text = String(format: "%02d", minute) + ":" + String(format: "%02d", seconds)
      } else {
        self.timeLabel.text = "인증 시간 만료"
        timer.invalidate()
      }
    }
    requestLabel.isHidden = false
    requestButton.isHidden = false
  }
  @objc private func didTapValidateNumber() {
  }
  @objc private func didTapReValidate() {
    timer?.invalidate()
    timeSet = 180
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      self.timeSet -= 1
      var minute = self.timeSet / 60
      var seconds = self.timeSet % 60
      if self.timeSet > 0 {
        self.timeLabel.text = String(format: "%02d", minute) + ":" + String(format: "%02d", seconds)
      } else {
        self.timeLabel.text = "인증 시간 만료"
        timer.invalidate()
      }
    }
  }
  @objc private func didTapNext() {
    let vc = SignupDetailViewController()
    vc.emailtextLabel.text = "emailtiettst"
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
extension SignupViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    emailText = emailTextField.text
  }
}
