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
    button.layer.cornerRadius = 20
    button.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(didTapCheck), for: .touchDown)
    return button
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
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
    label.textColor = .gray
    label.isHidden = true
    return label
  }()
  private let countImage1 = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    return imageView
  }()
  private let countCheck1 = {
    let label = UILabel()
    label.text = "약관 전체 동의하기"
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let countImage2 = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    return imageView
  }()
  private let countCheck2 = {
    let label = UILabel()
    label.text = "[필수] 개인정보 수집 및 이용 동의"
    label.textColor = .gray
    return label
  }()
  private let countImage3 = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    return imageView
  }()
  private let countCheck3 = {
    let label = UILabel()
    label.text = "[필수] HEET 이용 약관 동의"
    label.textColor = .gray
    return label
  }()
  private let countImage4 = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    return imageView
  }()
  private let countCheck4 = {
    let label = UILabel()
    label.text = "[필수] 만 14세 이상입니다."
    label.textColor = .gray
    return label
  }()
  private let countImage5 = {
    let imageView = UIImageView(image: UIImage(named: "checkedImage"))
    return imageView
  }()
  private let countCheck5 = {
    let label = UILabel()
    label.text = "[선택] 마케팅 활용 및 광고성 정보 수신 동의"
    label.textColor = .gray
    return label
  }()
  private let signupButton = {
    let button = UIButton()
    button.setTitle("회원 가입", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 30
    button.addTarget(self, action: #selector(didTapSignup), for: .touchDown)
    return button
  }()
  private let stackView1: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 5
    return stackView
  }()
  private let stackView2: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 5
    return stackView
  }()
  private let stackView3: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 5
    return stackView
  }()
  private let stackView4: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    stackView.spacing = 5
    return stackView
  }()
  private let stackView5: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    return stackView
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationItem.title = "회원 가입"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    configureUI()
  }
  @objc private func didTapCheck() {
    possibleCheck.isHidden = false
    possibleLabel.isHidden = false
  }
  @objc private func didTapSignup() {
    self.navigationController?.pushViewController(GreetingViewController(), animated: true)
  }
  private func configureUI() {
    [emailLabel, emailtextLabel, passwordTextfield, passwordLabel, passwordLineView, lineView, repasswordLineView, rePasswordLabel, rePasswordTextfield, doubleCheckButton, possibleCheck, possibleLabel, signupButton, stackView5, countImage1, countCheck1]
      .forEach { view.addSubview($0) }
    stackView1.addArrangedSubview(countImage2)
    stackView1.addArrangedSubview(countCheck2)
    stackView2.addArrangedSubview(countImage3)
    stackView2.addArrangedSubview(countCheck3)
    stackView3.addArrangedSubview(countImage4)
    stackView3.addArrangedSubview(countCheck4)
    stackView4.addArrangedSubview(countImage5)
    stackView4.addArrangedSubview(countCheck5)
    stackView5.addArrangedSubview(stackView1)
    stackView5.addArrangedSubview(stackView2)
    stackView5.addArrangedSubview(stackView3)
    stackView5.addArrangedSubview(stackView4)
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
      $0.height.equalTo(40)
      $0.right.equalTo(repasswordLineView.snp.right)
      $0.bottom.equalTo(rePasswordTextfield.snp.bottom)
    }
    possibleLabel.snp.makeConstraints {
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(20)
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
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.bottom.equalTo(signupButton.snp.top).offset(-20)
      $0.top.equalTo(countImage1.snp.bottom).offset(20)
      $0.width.equalTo(270)
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
