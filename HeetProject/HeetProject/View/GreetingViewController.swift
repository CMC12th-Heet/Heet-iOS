//
//  GreetingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/13.
//

import UIKit
import SnapKit

class GreetingViewController: UIViewController {
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
  private let idLabel = {
    let label = UILabel()
    label.text = "dg3785"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let nimLabel = {
    let label = UILabel()
    label.text = "님"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let lineView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let setLocation = {
    let button = UIButton()
    button.setTitle("동네 설정하기", for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 20
    button.addTarget(GreetingViewController.self, action: #selector(didTapSet), for: .touchDown)
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.image = nil
    configureUI()
  }
  @objc private func didTapSet() {
    //    self.navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
  }
  private func configureUI() {
    [logoImage, helloLabel, idLabel, nimLabel, lineView, setLocation]
      .forEach {
        view.addSubview($0)
      }
    logoImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.width.equalTo(100)
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
    setLocation.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
      $0.width.equalTo(350)
      $0.height.equalTo(60)
    }
  }
}
