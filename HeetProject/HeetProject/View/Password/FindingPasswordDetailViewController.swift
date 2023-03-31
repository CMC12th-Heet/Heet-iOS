//
//  FindingPasswordDetailViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/14.
//

import UIKit
import Alamofire

class FindingPasswordDetailViewController: UIViewController {
  private let passwordLabel = {
    let label = UILabel()
    label.text = "새 비밀번호를 입력하세요*"
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
    view.backgroundColor = .gray
    return view
  }()
  private let rePasswordLabel = {
    let label = UILabel()
    label.text = "비밀번호 재확인*"
    label.font = .systemFont(ofSize: 17)
    label.textColor = .gray
    return label
  }()
  private let rePasswordTextfield = {
    let textField = UITextField()
    textField.placeholder = "비밀번호 입력"
    textField.font = .systemFont(ofSize: 15)
    textField.textColor = .gray
    return textField
  }()
  private let repasswordLineView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let numberImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    return imageView
  }()
  private let numberCheck = {
    let label = UILabel()
    label.text = "숫자"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    return label
  }()
  private let englishImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    return imageView
  }()
  private let englishCheck = {
    let label = UILabel()
    label.text = "영문"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    return label
  }()
  private let specialImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    return imageView
  }()
  private let specialCheck = {
    let label = UILabel()
    label.text = "특수문자"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    return label
  }()
  private let countImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    return imageView
  }()
  private let countCheck = {
    let label = UILabel()
    label.text = "8자 이상"
    label.font = .systemFont(ofSize: 13)
    label.textColor = .gray
    return label
  }()
  private let reImage = {
    let imageView = UIImageView(image: UIImage(named: "uncheckedImage"))
    return imageView
  }()
  private let reCheck = {
    let label = UILabel()
    label.text = "일치합니다."
    label.textColor = .gray
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  private let stackview1 = {
    let stackview = UIStackView()
    stackview.alignment = .fill
    stackview.distribution = .equalSpacing
    stackview.spacing = 3
    return stackview
  }()
  private let stackview2 = {
    let stackview = UIStackView()
    stackview.alignment = .fill
    stackview.distribution = .equalSpacing
    stackview.spacing = 3
    return stackview
  }()
  private let stackview3 = {
    let stackview = UIStackView()
    stackview.alignment = .fill
    stackview.distribution = .equalSpacing
    stackview.spacing = 3
    return stackview
  }()
  private let stackview4 = {
    let stackview = UIStackView()
    stackview.alignment = .fill
    stackview.distribution = .equalSpacing
    stackview.spacing = 3
    return stackview
  }()
  private let stackview5 = {
    let stackview = UIStackView()
    stackview.axis = .vertical
    stackview.alignment = .leading
    stackview.distribution = .equalSpacing
    return stackview
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationItem.title = "비밀번호 재설정"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    configureUI()
    passwordTextfield.delegate = self
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  private func configureUI() {
    [passwordLabel, passwordTextfield, passwordLineView, repasswordLineView, rePasswordLabel, rePasswordTextfield, stackview5, reImage, reCheck]
      .forEach {
        view.addSubview($0)
      }
    [stackview1, stackview2, stackview3, stackview4]
      .forEach {
        stackview5.addArrangedSubview($0)
      }
    stackview1.addArrangedSubview(numberImage)
    stackview1.addArrangedSubview(numberCheck)
    stackview2.addArrangedSubview(englishImage)
    stackview2.addArrangedSubview(englishCheck)
    stackview3.addArrangedSubview(specialImage)
    stackview3.addArrangedSubview(specialCheck)
    stackview4.addArrangedSubview(countImage)
    stackview4.addArrangedSubview(countCheck)
    passwordLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(170)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
    }
    passwordTextfield.snp.makeConstraints {
      $0.top.equalTo(passwordLabel.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
    }
    passwordLineView.snp.makeConstraints {
      $0.top.equalTo(passwordTextfield.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(3)
    }
    rePasswordLabel.snp.makeConstraints {
      $0.top.equalTo(stackview5.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
    }
    rePasswordTextfield.snp.makeConstraints {
      $0.top.equalTo(rePasswordLabel.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
    }
    repasswordLineView.snp.makeConstraints {
      $0.top.equalTo(rePasswordTextfield.snp.bottom).offset(10)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.height.equalTo(3)
    }
    stackview5.snp.makeConstraints {
      $0.top.equalTo(passwordLineView.snp.bottom).offset(20)
      $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(35)
      $0.width.equalTo(200)
      $0.height.equalTo(100)
    }
    reImage.snp.makeConstraints {
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(20)
      $0.leading.equalTo(repasswordLineView.snp.leading).offset(20)
    }
    reCheck.snp.makeConstraints {
      $0.top.equalTo(repasswordLineView.snp.bottom).offset(20)
      $0.leading.equalTo(reImage.snp.trailing).offset(5)
    }
  }
}
extension FindingPasswordDetailViewController: UITextFieldDelegate {
  func textFieldDidChangeSelection(_ textField: UITextField) {
    passwordTextfield.isSecureTextEntry = true
    rePasswordTextfield.isSecureTextEntry = true
    for i in [specialImage, specialCheck, englishImage, englishCheck, numberCheck, numberImage, countCheck, countImage, reImage, reCheck] {
      i.isHidden = false
    }
    let password = passwordTextfield.text
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
      //      password = rePasswordTextfield.text
    } else {
      reCheck.isHidden = true
      reImage.isHidden = true
      reImage.image = UIImage(named: "checkedImage")
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapNext))
    }
  }
  @objc private func didTapNext() {
  }
}
