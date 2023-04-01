//
//  ViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/10.
//

import UIKit
import SnapKit
import Alamofire

final class LoginViewController: UIViewController {
  var email: String?
  var password: String?
  private let logoImage = {
    let imageView = UIImageView(image: UIImage(named: "LoginLogo"))
    return imageView
  }()
  private let emailTextField = {
    let textField = UITextField()
    textField.placeholder = "아이디 또는 이메일 입력"
    textField.layer.cornerRadius = 25
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    textField.backgroundColor = .systemGray5
    textField.font = .systemFont(ofSize: 15)
    return textField
  }()
  private let passwordTextField = {
    let textField = UITextField()
    textField.placeholder = "비밀번호 입력"
    textField.layer.cornerRadius = 25
    textField.backgroundColor = .systemGray5
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    textField.font = .systemFont(ofSize: 15)
    return textField
  }()
  private let emailAlertLabel = {
    let label = UILabel()
    label.textColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 이메일입니다."
    label.font = .systemFont(ofSize: 12, weight: .bold)
    label.isHidden = true
    return label
  }()
  private let passwordAlertLabel = {
    let label = UILabel()
    label.textColor = ColorManager.BackgroundColor
    label.text = "*가입되지 않은 이메일 or 비밀번호입니다."
    label.font = .systemFont(ofSize: 12, weight: .bold)
    label.isHidden = true
    return label
  }()
  private let loginButton = {
    let button = UIButton()
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitle("로그인", for: .normal)
    button.titleLabel!.font = .systemFont(ofSize: 17, weight: .bold)
    button.setTitleColor(UIColor.white, for: .normal)
    button.layer.cornerRadius = 25
    button.addTarget(self, action: #selector(gotoLogin), for: .touchDown)
    return button
  }()
  private let findPasswordButton = {
    let button = UIButton()
    button.setTitle("비밀번호 찾기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.titleLabel!.font = .systemFont(ofSize: 13, weight: .bold)
    button.addTarget(self, action: #selector(gotoFinding), for: .touchDown)
    return button
  }()
  private let gotoSignupButton = {
    let button = UIButton()
    button.setTitle("회원가입 하기", for: .normal)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.titleLabel!.font = .systemFont(ofSize: 13, weight: .bold)
    button.addTarget(self, action: #selector(gotoSignup), for: .touchDown)
    return button
  }()
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 30
    return stackView
  }()
  private let lineview: UIView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    emailTextField.delegate = self
    passwordTextField.delegate = self
    view.backgroundColor = .white
    configureUI()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  private func configureUI() {
    [logoImage, emailTextField, passwordTextField, emailAlertLabel, passwordAlertLabel, loginButton, stackView]
      .forEach { view.addSubview($0) }
    stackView.addArrangedSubview(findPasswordButton)
    stackView.addArrangedSubview(lineview)
    stackView.addArrangedSubview(gotoSignupButton)
    lineview.snp.makeConstraints {
      $0.width.equalTo(2)
      $0.height.equalTo(16)
    }
    logoImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
      $0.width.equalTo(65)
      $0.height.equalTo(22)
    }
    emailTextField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(160)
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
      $0.top.equalTo(passwordTextField.snp.bottom).offset(60)
      $0.width.equalTo(300)
      $0.height.equalTo(50)
    }
    stackView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(loginButton.snp.bottom).offset(10)
    }
  }
  @objc private func gotoSignup() {
    let vc = SignupViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  @objc private func gotoFinding() {
    let vc = FindingPasswordViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  @objc private func gotoLogin() {
    let body = [
      "email": email,
      "password": password
    ]
    self.passwordAlertLabel.isHidden = false
    NetworkService.shared.requestData(url: "/user/login", method: .post, params: body, headers: ["Content-Type" : "application/json"], parameters: JSONEncoding(), model: LoginModel.self) { response in
      switch response {
      case .success(let data):
        if let data = data as? LoginModel {
          MainLocationViewController.selectedCity = String(Array(data.town ?? "")[0...1])
          MainLocationViewController.selectedGu = String(Array(data.town ?? "")[3...])
          MainLocationViewController.myTownLabel.text = data.town
          print("meme \(data.message)")
          UserDefaults.standard.set(data.token, forKey: "loginToken")
          if UserDefaults.standard.string(forKey: "loginToken") != nil {
            print("yes")
            self.passwordAlertLabel.isHidden = true
            self.navigationController?.pushViewController(CustomTabBarController(), animated: false)
          } else {
            print("no")
            self.passwordAlertLabel.isHidden = true
          }
        }
      default: break
      }
    }
  }
}
extension LoginViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    email = emailTextField.text
    password = passwordTextField.text
    passwordTextField.isSecureTextEntry = true
  }
}
