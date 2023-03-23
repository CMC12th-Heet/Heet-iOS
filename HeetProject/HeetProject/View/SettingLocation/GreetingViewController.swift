//
//  GreetingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/13.
//

import UIKit
import SnapKit
import Alamofire

protocol dataProtocol {
  func setIsHiddenFalse()
}
class GreetingViewController: UIViewController {
  static var selectedLoc: [String]?
  var username = ""
  private let logoImage = {
    let imageView = UIImageView(image: UIImage(named: "LoginLogo"))
    return imageView
  }()
  private let helloLabel = {
    let label = UILabel()
    label.text = "안녕하세요"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 25, weight: .bold)
    return label
  }()
  let idLabel = {
    let label = UILabel()
    label.text = "label"
    label.font = .systemFont(ofSize: 15)
    label.textColor = .systemGray2
    return label
  }()
  private let nimLabel = {
    let label = UILabel()
    label.text = "님"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let lineView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  static var setLocation = {
    let button = UIButton()
    button.setTitle("동네 설정하기", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    button.backgroundColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 30
    button.addTarget(self, action: #selector(didTapSet), for: .touchDown)
    return button
  }()
  static let LocationImage = {
    let imageView = UIImageView(image: UIImage(named: "Location"))
    imageView.isHidden = true
    return imageView
  }()
  static var LocationLabel = {
    let label = UILabel()
    label.text = "서울시 용산구"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.isHidden = true
    return label
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationController?.navigationBar.isHidden = true
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.image = nil
    idLabel.text = signUsername
    configureUI()
  }
  @objc private func didTapSet() {
    if GreetingViewController.setLocation.titleLabel?.text == "동네 설정하기" {
      self.navigationController?.pushViewController(LocationViewController(), animated: false)
    } else {
      let vc = UINavigationController(rootViewController: LoginViewController())
      vc.modalPresentationStyle = .overFullScreen
      self.present(vc, animated: true)
      //      self.navigationController?.pushViewController(CustomTabBarController(), animated: false)
    }
  }
  private func configureUI() {
    [logoImage, helloLabel, idLabel, nimLabel, lineView, GreetingViewController.setLocation, GreetingViewController.LocationImage, GreetingViewController.LocationLabel]
      .forEach {
        view.addSubview($0)
      }
    logoImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.width.equalTo(65)
      $0.height.equalTo(22)
    }
    helloLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(idLabel.snp.top).offset(-50)
    }
    idLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(lineView.snp.top).offset(-5)
    }
    nimLabel.snp.makeConstraints {
      $0.left.equalTo(idLabel.snp.right).offset(5)
      $0.bottom.equalTo(lineView.snp.top).offset(-5)
    }
    lineView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
      $0.width.equalTo(200)
      $0.height.equalTo(1)
    }
    GreetingViewController.setLocation.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
      $0.width.equalTo(350)
      $0.height.equalTo(60)
    }
    GreetingViewController.LocationLabel.snp.makeConstraints {
      $0.bottom.equalTo(GreetingViewController.setLocation.snp.top).offset(-30)
      $0.centerX.equalToSuperview()
    }
    GreetingViewController.LocationImage.snp.makeConstraints {
      $0.bottom.equalTo(GreetingViewController.LocationLabel.snp.top).offset(-10)
      $0.centerX.equalToSuperview()
    }
  }
}
