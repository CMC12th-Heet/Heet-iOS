//
//  MainValidateViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/06.
//

import UIKit
import CoreLocation

class MainValidateViewController: UIViewController, CLLocationManagerDelegate {
  var locationManager = CLLocationManager()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "첫 게시글을 작성하기 전\n위치 인증을 진행해주세요!"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15)
    label.numberOfLines = 0
    return label
  }()
  private let button: UIButton = {
    let button = UIButton()
    button.setTitle("인증하기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.tintColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 20
    button.layer.borderColor = ColorManager.BackgroundColor.cgColor
    button.addTarget(self, action: #selector(didTapValidate), for: .touchDown)
    return button
  }()
  @objc private func didTapValidate() {
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      print("on \(locationManager)")
    } else {
      print("off")
    }
    [label, button]
      .forEach {
        view.addSubview($0)
      }
    label.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(286)
    }
    button.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(60)
    }
  }
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      print("위도: \(location.coordinate.latitude)")
      print("경도: \(location.coordinate.longitude)")
    }
    navigationController?.popViewController(animated: false)
  }
}
