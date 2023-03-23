//
//  SignupIdViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/12.
//

import UIKit
import SnapKit
import SafariServices

var signemail = ""
var signPassword = ""
var signUsername = ""
var signTown = ""

class SignupIdViewController: UIViewController {
  private var isValidated = true
  var sendPassword = ""
  var username = ""
  var totalcheck = false
  var ch1 = false
  var ch2 = false
  var ch3 = false
  var ch4 = false
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일"
    label.textColor = .gray
    return label
  }()
  let emailtextLabel = {
    let label = UILabel()
    label.text = ""
    label.textColor = .systemGray4
    return label
  }()
  private let passwordLabel = {
    let label = UILabel()
    label.text = "비밀번호"
    label.textColor = .gray
    return label
  }()
  lazy var passwordTextfield = {
    let label = UILabel()
    label.text = String(repeating: "*", count: self.sendPassword.count)
    label.textColor = .systemGray4
    return label
  }()
  private let rePasswordLabel = {
    let label = UILabel()
    label.text = "아이디를 설정하세요*"
    label.textColor = .gray
    return label
  }()
  private let rePasswordTextfield = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "Id 입력"
    return textField
  }()
  private let doubleCheckButton = {
    let button = UIButton()
    button.setTitle("중복 확인", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 20
    button.layer.borderColor = ColorManager.BackgroundColor.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(didTapCheck), for: .touchDown)
    return button
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let possibleCheck = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    imageView.isHidden = true
    return imageView
  }()
  private let possibleLabel = {
    let label = UILabel()
    label.text = "사용 가능합니다."
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private var detail1 = {
    let button = UIButton()
    button.setTitle("자세히", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.addTarget(self, action: #selector(didtapdetail1), for: .touchDown)
    return button
  }()
  private var detail2 = {
    let button = UIButton()
    button.setTitle("자세히", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.addTarget(self, action: #selector(didtapdetail2), for: .touchDown)
    return button
  }()
  private var detail3 = {
    let button = UIButton()
    button.setTitle("자세히", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.setTitleColor(UIColor.gray, for: .normal)
    button.addTarget(self, action: #selector(diddtapdetail3), for: .touchDown)
    return button
  }()
  @objc private func didtapdetail1() {
    let url1 = NSURL(string: "https://heetkr.notion.site/003152352a4e4f05b3607b1a790d3827")
    let view1: SFSafariViewController = SFSafariViewController(url: url1 as! URL)
    self.present(view1, animated: true, completion: nil)
  }
  @objc private func didtapdetail2() {
    let url2 = NSURL(string: "https://heetkr.notion.site/HEET-6590ce86b1b54526ad1fead10ae8f9b9")
    let view2: SFSafariViewController = SFSafariViewController(url: url2 as! URL)
    self.present(view2, animated: true, completion: nil)
  }
  @objc private func diddtapdetail3() {
    let url3 = NSURL(string: "https://heetkr.notion.site/7d1df952675344f58640174795208fd6")
    let view3: SFSafariViewController = SFSafariViewController(url: url3 as! URL)
    self.present(view3, animated: true, completion: nil)
  }
  
  private var countImage1 = {
    let button = UIButton()
    button.setImage(UIImage(named: "uncheckedImage"), for: .normal)
    button.isHidden = true
    button.addTarget(self, action: #selector(didTapImage), for: .touchDown)
    return button
  }()
  @objc private func didTapImage() {
    if totalcheck {
      countImage1.setImage(UIImage(named: "uncheckedImage"), for: .normal)
      countImage2.setImage(UIImage(named: "idCheck"), for: .normal)
      countImage3.setImage(UIImage(named: "idCheck"), for: .normal)
      countImage4.setImage(UIImage(named: "idCheck"), for: .normal)
      countImage5.setImage(UIImage(named: "idCheck"), for: .normal)
    } else {
      countImage1.setImage(UIImage(named: "checkedImage"), for: .normal)
      countImage2.setImage(UIImage(named: "basiccheck"), for: .normal)
      countImage3.setImage(UIImage(named: "basiccheck"), for: .normal)
      countImage4.setImage(UIImage(named: "basiccheck"), for: .normal)
      countImage5.setImage(UIImage(named: "basiccheck"), for: .normal)
    }
    totalcheck.toggle()
  }
  @objc private func didTapImage1() {
    if ch1 {
      countImage2.setImage(UIImage(named: "idCheck"), for: .normal)
    } else {
      countImage2.setImage(UIImage(named: "basiccheck"), for: .normal)
    }
    ch1.toggle()
  }
  @objc private func didTapImage2() {
    if ch2 {
      countImage3.setImage(UIImage(named: "idCheck"), for: .normal)
    } else {
      countImage3.setImage(UIImage(named: "basiccheck"), for: .normal)
    }
    ch2.toggle()
  }
  @objc private func didTapImage3() {
    if ch3 {
      countImage4.setImage(UIImage(named: "idCheck"), for: .normal)
    } else {
      countImage4.setImage(UIImage(named: "basiccheck"), for: .normal)
    }
    ch3.toggle()
  }
  @objc private func didTapImage4() {
    if ch4 {
      countImage5.setImage(UIImage(named: "idCheck"), for: .normal)
    } else {
      countImage5.setImage(UIImage(named: "basiccheck"), for: .normal)
    }
    ch4.toggle()
  }
  private let countCheck1 = {
    let label = UILabel()
    label.text = "약관 전체 동의하기"
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.isHidden = true
    return label
  }()
  private let countImage2 = {
    let button = UIButton()
    button.setImage(UIImage(named: "idCheck"), for: .normal)
    button.addTarget(self, action: #selector(didTapImage1), for: .touchDown)
    return button
  }()
  private let countCheck2 = {
    let label = UILabel()
    label.text = "[필수] 개인정보 수집 및 이용 동의"
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    
    return label
  }()
  private let countImage3 = {
    let button = UIButton()
    button.setImage(UIImage(named: "idCheck"), for: .normal)
    button.addTarget(self, action: #selector(didTapImage2), for: .touchDown)
    return button
  }()
  private let countCheck3 = {
    let label = UILabel()
    label.text = "[필수] HEET 이용 약관 동의"
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    return label
  }()
  private let countImage4 = {
    let button = UIButton()
    button.setImage(UIImage(named: "idCheck"), for: .normal)
    button.addTarget(self, action: #selector(didTapImage3), for: .touchDown)
    return button
  }()
  private let countCheck4 = {
    let label = UILabel()
    label.text = "[필수] 만 14세 이상입니다."
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    return label
  }()
  private let countImage5 = {
    let button = UIButton()
    button.setImage(UIImage(named: "idCheck"), for: .normal)
    button.addTarget(self, action: #selector(didTapImage4), for: .touchDown)
    return button
  }()
  private let countCheck5 = {
    let label = UILabel()
    label.text = "[선택] 마케팅 활용 및 광고성 정보 수신 동의"
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    return label
  }()
  private let signupButton = {
    let button = UIButton()
    button.setTitle("회원 가입", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 30
    button.isUserInteractionEnabled = false
    button.addTarget(self, action: #selector(didTapSignup), for: .touchDown)
    return button
  }()
  private let stackView1: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()
  private let stackView2: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()
  private let stackView3: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()
  private let stackView4: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()
  private let stackView5: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    stackView.isHidden = true
    return stackView
  }()
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationItem.title = "회원 가입"
    self.navigationController?.navigationBar.backItem?.backBarButtonItem = nil
    rePasswordTextfield.delegate = self
    configureUI()
  }
  @objc private func didTapCheck() {
    let body = [
      "username": self.username
    ]
    NetworkService().varifyId(url: "/user/find-duplicate", method: .post, params: body, headers: ["Content-Type" : "application/json"], model: CheckingIdModel.self) {
      self.doubleCheckButton.setTitleColor(.white, for: .normal)
      self.doubleCheckButton.backgroundColor = ColorManager.BackgroundColor
      self.possibleLabel.isHidden = false
      print("ss \(self.username)")
      print("du \(isDuplicated)")
      if isDuplicated == false {
        self.repasswordLineView.backgroundColor = .systemGray5
        self.doubleCheckButton.isHidden = true
        self.stackView5.isHidden = false
        self.countCheck1.isHidden = false
        self.countImage1.isHidden = false
        self.possibleCheck.isHidden = false
        self.signupButton.isUserInteractionEnabled = true
        print("ussusuer \(isDuplicated)")
      } else {
        self.possibleLabel.text = "*이미 사용 중인 아이디입니다."
        //        self.doubleCheckButton.isUserInteractionEnabled = true
        self.possibleCheck.isHidden = true
        self.signupButton.isUserInteractionEnabled = false
      }
    }
  }
  @objc private func didTapSignup() {
    if (ch1 && ch2 && ch3 && ch4) || totalcheck {
      signupButton.isUserInteractionEnabled = true
    }
    signemail = self.emailtextLabel.text ?? ""
    signUsername = self.username
    print("sd \(self.username)")
    print("sig \(signUsername)")
    signPassword = self.sendPassword
    let vc = GreetingViewController()
    vc.username = self.username
    self.navigationController?.pushViewController(vc, animated: true)
  }
  private func configureUI() {
    [emailLabel, emailtextLabel, passwordTextfield, passwordLabel, repasswordLineView, rePasswordLabel, rePasswordTextfield, doubleCheckButton, possibleCheck, possibleLabel, signupButton, stackView5, countImage1, countCheck1]
      .forEach { view.addSubview($0) }
    stackView1.addArrangedSubview(countImage2)
    stackView1.addArrangedSubview(countCheck2)
    stackView1.addArrangedSubview(detail1)
    stackView2.addArrangedSubview(countImage3)
    stackView2.addArrangedSubview(countCheck3)
    stackView2.addArrangedSubview(detail2)
    stackView3.addArrangedSubview(countImage4)
    stackView3.addArrangedSubview(countCheck4)
    stackView4.addArrangedSubview(countImage5)
    stackView4.addArrangedSubview(countCheck5)
    stackView4.addArrangedSubview(detail3)
    stackView5.addArrangedSubview(stackView1)
    stackView5.addArrangedSubview(stackView2)
    stackView5.addArrangedSubview(stackView3)
    stackView5.addArrangedSubview(stackView4)
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
      $0.left.equalToSuperview().offset(30)
    }
    emailtextLabel.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.top)
      $0.trailing.equalToSuperview().offset(-20)
    }
    passwordLabel.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(30)
      $0.left.equalToSuperview().offset(30)
    }
    passwordTextfield.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.top)
      $0.trailing.equalToSuperview().offset(-20)
    }
    rePasswordLabel.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.bottom).offset(100)
      $0.left.equalToSuperview().offset(30)
    }
    rePasswordTextfield.snp.makeConstraints {
      $0.top.equalTo(rePasswordLabel.snp.bottom).offset(20)
      $0.left.equalToSuperview().offset(30)
    }
    repasswordLineView.snp.makeConstraints {
      $0.top.equalTo(rePasswordTextfield.snp.bottom).offset(10)
      $0.left.equalTo(emailLabel.snp.left)
      $0.width.equalTo(350)
      $0.height.equalTo(3)
    }
    doubleCheckButton.snp.makeConstraints {
      $0.width.equalTo(100)
      $0.height.equalTo(40)
      $0.right.equalTo(repasswordLineView.snp.right)
      $0.bottom.equalTo(rePasswordTextfield.snp.bottom)
    }
    possibleLabel.snp.makeConstraints {
      $0.centerY.equalTo(possibleCheck.snp.centerY)
      $0.left.equalTo(possibleCheck.snp.right).offset(10)
    }
    possibleCheck.snp.makeConstraints {
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(20)
      $0.left.equalTo(repasswordLineView.snp.left).offset(20)
      $0.width.equalTo(20)
      $0.height.equalTo(20)
    }
    signupButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
      $0.width.equalTo(350)
      $0.height.equalTo(60)
    }
    stackView5.snp.makeConstraints {
      $0.leading.equalTo(repasswordLineView.snp.leading).offset(20)
      $0.trailing.equalTo(repasswordLineView.snp.trailing)
      $0.top.equalTo(countImage1.snp.bottom).offset(20)
      $0.height.equalTo(130)
    }
    countImage1.snp.makeConstraints {
      $0.left.equalTo(repasswordLineView.snp.left).offset(20)
      $0.top.equalTo(possibleCheck.snp.bottom).offset(20)
      $0.width.equalTo(20)
      $0.height.equalTo(20)
    }
    countCheck1.snp.makeConstraints {
      $0.top.equalTo(possibleCheck.snp.bottom).offset(20)
      $0.left.equalTo(countImage1.snp.right).offset(10)
    }
  }
}
extension SignupIdViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    username = textField.text ?? ""
  }
}
