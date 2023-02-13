//
//  FindingPasswordViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/14.
//

import UIKit
import SnapKit

class FindingPasswordViewController: UIViewController {
  private let emailLabel = {
    let label = UILabel()
    label.text = "이메일"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let emailInput = {
    let textField = UITextField()
    textField.placeholder = "이멜이멜"
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
    //    button.addTarget(self, action: #selector(didTapValidateNumber), for: .allTouchEvents)
    return button
  }()
  private let validateNumber = {
    let textField = UITextField()
    textField.placeholder = "인증코드 입력"
    textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
    textField.leftViewMode = .always
    return textField
  }()
  private let validateNumberButton2 = {
    let button = UIButton()
    button.setTitle("인증 요청", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 25
    button.layer.borderWidth = 1
    button.layer.borderColor = ColorManager.BackgroundColor?.cgColor
    //    button.addTarget(self, action: #selector(didTapValidateNumber), for: .allTouchEvents)
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
  private let lineView2 = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let nextButton = {
    let button = UIButton()
    button.setTitle("다음", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.tintColor = ColorManager.BackgroundColor
    button.semanticContentAttribute = .forceRightToLeft
    //    button.addTarget(self, action: #selector(didTapNext), for: .touchDown)
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationItem.title = "비밀번호 찾기"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    configureUI()
  }
  private func configureUI() {
    [emailInput, emailLabel, lineView, lineView2, validateNumber, validateNumberButton, validateNumberButton2, requestLabel, requestButton, nextButton]
      .forEach {
        view.addSubview($0)
      }
    emailLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(200)
      $0.leading.equalToSuperview().offset(20)
    }
    emailInput.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    lineView.snp.makeConstraints {
      $0.top.equalTo(emailInput.snp.bottom).offset(5)
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalTo(350)
      $0.height.equalTo(2)
    }
    validateNumberButton.snp.makeConstraints {
      $0.bottom.equalTo(lineView.snp.top).offset(-5)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.width.equalTo(100)
      $0.height.equalTo(40)
    }
    validateNumber.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    lineView2.snp.makeConstraints {
      $0.top.equalTo(validateNumber.snp.bottom).offset(5)
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalTo(350)
      $0.height.equalTo(2)
    }
    validateNumberButton2.snp.makeConstraints {
      $0.bottom.equalTo(lineView2.snp.top).offset(-5)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
      $0.width.equalTo(100)
      $0.height.equalTo(40)
    }
    requestLabel.snp.makeConstraints {
      $0.top.equalTo(lineView2.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
    }
    requestButton.snp.makeConstraints {
      $0.top.equalTo(lineView2.snp.bottom).offset(10)
      $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
    }
    nextButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-300)
      $0.trailing.equalToSuperview().offset(-20)
    }
  }
}
