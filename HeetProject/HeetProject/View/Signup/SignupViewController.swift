//
//  SignupViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/11.
//

import UIKit
import SnapKit
import Alamofire

class SignupViewController: UIViewController {
  var emailText: String = ""
  var timeSet: Int = 180
  var timer: Timer?
  var isValidated = true
  private let emailTextField = {
    let textField = UITextField()
    textField.placeholder = "이메일 입력"
    textField.font = .systemFont(ofSize: 15)
    textField.backgroundColor = .systemGray4
    textField.layer.cornerRadius = 25
    textField.layer.borderColor = ColorManager.BackgroundColor.cgColor
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    return textField
  }()
  private let validateButton = {
    let button = UIButton()
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitle("이메일 인증하기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 25
    button.addTarget(self, action: #selector(didTapValidate), for: .touchDown)
    return button
  }()
  private let emailImage = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일 전송이 성공되었습니다.\n인증 코드 6자리를 입력해주세요."
    label.font = .systemFont(ofSize: 14)
    label.numberOfLines = 0
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
    textField.font = .systemFont(ofSize: 15)
    textField.leftViewMode = .always
    return textField
  }()
  private let timeLabel = {
    let label = UILabel()
    label.text = "03:00"
    label.font = .systemFont(ofSize: 14, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let validateNumberButton = {
    let button = UIButton()
    button.setTitle("인증 요청", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 20
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    button.layer.borderWidth = 1
    button.layer.borderColor = ColorManager.BackgroundColor.cgColor
    button.addTarget(self, action: #selector(didTapValidateNumber), for: .touchDown)
    button.isUserInteractionEnabled = false
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
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let requestButton = {
    let button = UIButton()
    button.setTitle("재전송하기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.isHidden = true
    button.titleLabel?.font = .systemFont(ofSize: 12)
    button.addTarget(self, action: #selector(didTapReValidate), for: .touchDown)
    return button
  }()
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    emailTextField.delegate = self
    configureUI()
    configureNavigation()
  }
  private func configureNavigation() {
    self.navigationController?.navigationBar.isHidden = false
    self.navigationItem.title = "회원 가입"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = .black
    self.navigationController?.navigationBar.topItem?.titleView?.tintColor = ColorManager.BackgroundColor
  }
  private func configureUI() {
    [emailTextField, validateButton, emailImage, emailLabel, validateNumber, validateNumberButton, lineView, requestButton, requestLabel, emailLabel2, timeLabel]
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
      $0.width.equalTo(25)
      $0.height.equalTo(25)
    }
    emailLabel.snp.makeConstraints {
      $0.left.equalTo(emailImage.snp.right).offset(10)
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
      $0.width.equalTo(105)
      $0.height.equalTo(38)
    }
    requestLabel.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(20)
      $0.left.equalTo(lineView.snp.left).offset(10)
    }
    requestButton.snp.makeConstraints {
      $0.right.equalTo(lineView.snp.right).offset(-10)
      $0.centerY.equalTo(requestLabel.snp.centerY)
    }
    timeLabel.snp.makeConstraints {
      $0.trailing.equalTo(validateNumberButton.snp.leading).offset(-15)
      $0.centerY.equalTo(validateNumber.snp.centerY)
    }
  }
  @objc private func didTapValidate() {
    requestNumber()
  }
  @objc private func didTapValidateNumber() {
    if emailCode == validateNumber.text ?? "" {
      validateNumberButton.backgroundColor = ColorManager.BackgroundColor
      validateNumberButton.setTitleColor(.white, for: .normal)
      validateNumberButton.setTitle("인증 완료", for: .normal)
      validateNumber.isUserInteractionEnabled = false
      if isValidated == true {
        timer?.invalidate()
      }
      let alert = UIAlertController(title: "인증되었습니다!", message: "", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : {_ in
        let vc = SignupDetailViewController()
        vc.emailtextLabel.text = self.emailText
        self.navigationController?.pushViewController(vc, animated: false)
      })
      alert.addAction(defaultAction)
      self.present(alert, animated: false, completion: nil)
    } else {
      let alert = UIAlertController(title: "인증번호를 다시 확인해주세요.", message: "", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)
      alert.addAction(defaultAction)
      present(alert, animated: false, completion: nil)
    }
  }
  @objc private func didTapReValidate() {
    requestReNumber()
  }
  private func requestNumber() {
    let body: Parameters = [
      "email": emailTextField.text
    ]
    NetworkService.shared.requestData(url: "/user/email-verify", method: .post, params: body, headers: ["Content-Type" : "application/json"], parameters: JSONEncoding(), model: SignupModel.self) { response in
      switch response {
      case .success(let data):
        if let data = data as? SignupModel {
          emailCode = String(data.code)
          self.emailLabel.isHidden = false
          self.emailImage.isHidden = false
          self.validateButton.isUserInteractionEnabled = false
          self.validateNumberButton.isUserInteractionEnabled = true
          self.validateButton.backgroundColor = .gray
          self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
          self.requestLabel.isHidden = false
          self.requestButton.isHidden = false
        }
      default: break
      }
    }
  }
  private func requestReNumber() {
    let body = [
      "email": emailText
    ]
    NetworkService.shared.requestData(url: "/user/email-verify", method: .post, params: body, headers: ["Content-Type" : "application/json"], parameters: JSONEncoding(), model: SignupModel.self) {
      response in
      switch response {
      case .success(let data):
        if let data = data as? SignupModel {
          emailCode = String(data.code)
          self.timer?.invalidate()
          self.timeSet = 180
          let alert = UIAlertController(title: "재전송되었습니다!", message: "", preferredStyle: .alert)
          let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : nil)
          alert.addAction(defaultAction)
          self.present(alert, animated: false, completion: nil)
          self.validateNumberButton.setTitle("인증 요청", for: .normal)
          self.validateNumberButton.isUserInteractionEnabled = true
          self.validateNumber.isUserInteractionEnabled = true
          self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
      default: break
      }
    }
  }
}
extension SignupViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    emailText = textField.text ?? "n/a"
  }
}
