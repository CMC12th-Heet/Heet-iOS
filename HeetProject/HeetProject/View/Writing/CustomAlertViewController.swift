//
//  CustomAlertViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/11.
//

import UIKit

class CustomAlertViewController: UIViewController {
  var islogout = false
  var isRemove = false
  private let alertView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 20
    return view
  }()
  let alertLabel: UILabel = {
    let label = UILabel()
    label.text = "작성 중인 내용들이 있어요!\n그래도 나가시겠습니까?"
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 15)
    label.textColor = .gray
    return label
  }()
  private let confirmButton: UIButton = {
    let button = UIButton()
    button.setTitle("취소", for: .normal)
    button.backgroundColor = .gray
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    button.layer.cornerRadius = 20
    button.addTarget(self, action: #selector(didTapCancel), for: .touchDown)
    return button
  }()
  private let cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.backgroundColor = ColorManager.BackgroundColor
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
    button.layer.cornerRadius = 20
    button.addTarget(self, action: #selector(didTapConfirm), for: .touchDown)
    return button
  }()
  var delegate: sendDelegate?
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    setConstraint()
  }
  private func setConstraint() {
    view.addSubview(alertView)
    [alertLabel, confirmButton, cancelButton]
      .forEach {
        alertView.addSubview($0)
      }
    alertView.snp.makeConstraints {
      $0.width.equalTo(284)
      $0.height.equalTo(226)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
    alertLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(60)
      $0.centerX.equalToSuperview()
    }
    confirmButton.snp.makeConstraints {
      $0.width.equalTo(100)
      $0.height.equalTo(40)
      $0.top.equalTo(alertLabel.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(30)
    }
    cancelButton.snp.makeConstraints {
      $0.width.equalTo(100)
      $0.height.equalTo(40)
      $0.top.equalTo(alertLabel.snp.bottom).offset(30)
      $0.trailing.equalToSuperview().offset(-30)
    }
  }
  @objc private func didTapConfirm() {
    if islogout == true {
      UserDefaults.standard.set(nil, forKey: "loginToken")
      self.navigationController?.pushViewController(LoginViewController(), animated: true)
      islogout = false
    } else {
      self.delegate?.pop()
    }
    self.dismiss(animated: true)
  }
  @objc private func didTapCancel() {
    self.dismiss(animated: true)
  }
}
protocol sendDelegate {
  func pop()
}
