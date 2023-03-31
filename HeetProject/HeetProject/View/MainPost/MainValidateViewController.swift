//
//  MainValidateViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/06.
//

import UIKit
import CoreLocation
import Photos
import BSImagePicker
import Alamofire

class MainValidateViewController: UIViewController, CLLocationManagerDelegate {
  var locationManager = CLLocationManager()
  //위도와 경도
  var latitude: Double?
  var longitude: Double?
  let floatingButton: UIButton = {
    let button = UIButton(type: .system)
    button.isUserInteractionEnabled = false
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "pencil"), for: .normal)
    button.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    button.backgroundColor = .white
    button.tintColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 5
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOpacity = 1.0
    button.layer.shadowOffset = CGSize.zero
    button.layer.shadowRadius = 6
    return button
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "첫 게시글을 작성하기 전\n위치 인증을 진행해주세요!"
    label.textColor = .gray
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.numberOfLines = 0
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.text = "*초기 설정과 다른 위치입니다."
    label.isHidden = true
    label.textColor = ColorManager.BackgroundColor
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 11, weight: .bold)
    label.numberOfLines = 0
    return label
  }()
  private let button: UIButton = {
    let button = UIButton()
    button.setTitle("인증하기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.layer.cornerRadius = 20
    button.layer.borderWidth = 1
    button.layer.borderColor = ColorManager.BackgroundColor.cgColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(didTapValidate), for: .touchDown)
    return button
  }()
  fileprivate func setLocationManager() {
    // 델리게이트를 설정하고,
    locationManager.delegate = self
    // 거리 정확도
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    // 위치 사용 허용 알림
    locationManager.requestWhenInUseAuthorization()
    // 위치 사용을 허용하면 현재 위치 정보를 가져옴
    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
    }
    else {
      print("위치 서비스 허용 off")
    }
  }
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      print("위치 업데이트!")
      latitude = location.coordinate.latitude
      longitude = location.coordinate.longitude
      print("위도 : \(location.coordinate.latitude)")
      print("경도 : \(location.coordinate.longitude)")
    }
  }
  // 위치 가져오기 실패
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error")
  }
  @objc private func didTapValidate() {
    setLocationManager()
    //    locationManager = CLLocationManager()
    //    locationManager.delegate = self
    //    //포그라운드 상태에서 위치 추적 권한 요청
    //    locationManager.requestWhenInUseAuthorization()
    //    //배터리에 맞게 권장되는 최적의 정확도
    //    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    //    locationManager.startUpdatingLocation()
    //    let coor = locationManager.location?.coordinate
    //    latitude = coor?.latitude
    //    longitude = coor?.longitude
    //    print("lala \(latitude)")
    //    print("dfdf \(longitude)")
    floatingButton.isUserInteractionEnabled = true
    let param: Parameters = [
      "x": latitude,
      "y": longitude
    ]
    NetworkService().getMainPost(url: "/post/verify", method: .post, params: param, headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"], model: LocationModel.self) { response in
      switch response.result {
      case .success(let response):
        print("sc \(response.message)")
        if response.message == "fail" {
          self.label2.isHidden = false
        } else {
          self.label2.text = "인증되었습니다."
          let alert = UIAlertController(title: "인증되었습니다!", message: "", preferredStyle: .alert)
          let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : {_ in
          })
          alert.addAction(defaultAction)
          self.present(alert, animated: false, completion: nil)
        }
      case .failure(let error):
        print(error)
        self.label2.isHidden = false
      }
      UserDefaults.standard.set(true, forKey: "isVerify")
    }
  }
  @objc private func didTapButton() {
    let imagePicker = ImagePickerController()
    imagePicker.settings.selection.max = 10
    presentImagePicker(imagePicker, select: { (asset) in
      if imagePicker.selectedAssets.count == 3 {
        imagePicker.deselect(asset: asset)
        let alert = UIAlertController(title: "", message: "사진은 10장까지 선택 가능합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        imagePicker.present(alert, animated: true)
      }
    }, deselect: { (asset) in
    }, cancel: { (assets) in
    }, finish: { (assets) in
      var imageArr: [UIImage] = []
      assets.forEach {
        PHImageManager.default().requestImage(for: $0, targetSize: .zero, contentMode: .aspectFill, options: .none) { (image, info) in
          imageArr.append(image ?? UIImage())
        }
      }
      let vc = WritingViewController()
      vc.imageNames = imageArr
      self.navigationController?.pushViewController(vc, animated: false)
    })
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if isComplete == 1 {
      self.navigationController?.popViewController(animated: false)
    }
    tabBarController?.tabBar.isHidden = false
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = true
    view.backgroundColor = .white
    [label, label2, button, floatingButton]
      .forEach {
        view.addSubview($0)
      }
    floatingButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-44)
      $0.bottom.equalToSuperview().offset(-105)
      $0.width.equalTo(44)
      $0.height.equalTo(44)
    }
    label.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(286)
    }
    label2.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(label.snp.bottom).offset(30)
    }
    button.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(label.snp.bottom).offset(70)
      $0.width.equalTo(130)
      $0.height.equalTo(40)
    }
  }
}
