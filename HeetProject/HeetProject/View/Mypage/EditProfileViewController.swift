//
//  EditProfileViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController, sendDelegate {
  func pop() {
    NetworkService.shared.deleteUser { result in
      switch result {
      case .success(let response):
        print(response)
        self.present(LoginViewController(), animated: true)
      default: print(result)
      }
    }
  }
  var delegate: sendDelegate?
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  private let logout: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    button.addTarget(self, action: #selector(didTapLogout), for: .touchDown)
    return button
  }()
  private let exit: UIButton = {
    let button = UIButton()
    button.setTitle("회원탈퇴", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    button.addTarget(self, action: #selector(didTapExit), for: .touchDown)
    return button
  }()
  private let label1: UILabel = {
    let label = UILabel()
    label.text = "이름(필수)"
    label.font = .systemFont(ofSize: 13, weight: .bold)
    label.textColor = .systemGray
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.text = "아이디(필수)"
    label.font = .systemFont(ofSize: 13, weight: .bold)
    label.textColor = .systemGray
    return label
  }()
  private let label3: UILabel = {
    let label = UILabel()
    label.text = "소개글 작성"
    label.font = .systemFont(ofSize: 13, weight: .bold)
    label.textColor = .systemGray
    return label
  }()
  private let label4: UILabel = {
    let label = UILabel()
    label.text = "중구 약수동"
    label.font = .systemFont(ofSize: 15, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let label5: UILabel = {
    let label = UILabel()
    label.text = "숫자/영문/특수문자 중 두가지 이상, 8자~32자"
    label.font = .systemFont(ofSize: 11)
    label.textColor = .gray
    return label
  }()
  private let label6: UILabel = {
    let label = UILabel()
    label.text = "최대 30자"
    label.font = .systemFont(ofSize: 11)
    label.textColor = .gray
    return label
  }()
  private let label7: UILabel = {
    let label = UILabel()
    label.text = "지역 변경하기"
    label.font = .systemFont(ofSize: 11, weight: .bold)
    label.textColor = .gray
    return label
  }()
  private let imageview2: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "Location"))
    return imageview
  }()
  private let lineview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "line1"))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  private let text1: UITextField = {
    let text = UITextField()
    text.textColor = .gray
    text.layer.cornerRadius = 17
    text.layer.borderWidth = 1
    text.layer.borderColor = UIColor.systemGray2.cgColor
    text.font = .systemFont(ofSize: 15, weight: .bold)
    text.setLeftPaddingPoints(20)
    return text
  }()
  private let text2: UITextField = {
    let text = UITextField()
    text.textColor = .gray
    text.layer.cornerRadius = 17
    text.layer.borderWidth = 1
    text.layer.borderColor = UIColor.systemGray2.cgColor
    text.font = .systemFont(ofSize: 15, weight: .bold)
    text.setLeftPaddingPoints(20)
    return text
  }()
  private let text3: UITextView = {
    let text = UITextView()
    text.textColor = .gray
    text.layer.cornerRadius = 20
    text.layer.borderWidth = 1
    text.layer.borderColor = UIColor.systemGray2.cgColor
    text.font = .systemFont(ofSize: 15, weight: .bold)
    text.text = "  소개글을 작성해주세요."
    return text
  }()
  private let stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.distribution = .equalSpacing
    stackview.spacing = 80
    stackview.axis = .horizontal
    return stackview
  }()
  private let aline: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  @objc private func didTapEdit() {
    let body = [
      "username": text1.text ?? "",
      "town": "\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)",
      "status": text3.text ?? ""
    ]
    AF.request(Resource.baseURL + "/user/my-page",
               method: .post,
               parameters: body,
               encoding: JSONEncoding(),
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken")!)"])
    .validate()
    .response { _ in
      let alert = UIAlertController(title: "수정되었습니다!", message: "", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .destructive, handler : {_ in
        AF.request(Resource.baseURL + "/user/my-page",
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding(),
                   headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken")!)"])
      })
      alert.addAction(defaultAction)
      self.present(alert, animated: false, completion: nil)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.topItem?.title = "프로필 수정"
    setConstraint()
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    label4.text = mypageModel?.town
    text1.text = mypageModel?.username
    text2.text = mypageModel?.email
    self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapEdit))
    self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = ColorManager.BackgroundColor
  }
  private func setConstraint() {
    [imageview, imageview2, stackview, label1, label2, label3, label4, label5, label6, label7, text1, text2, text3, lineview]
      .forEach {
        view.addSubview($0)
      }
    stackview.addArrangedSubview(logout)
    stackview.addArrangedSubview(aline)
    stackview.addArrangedSubview(exit)
    imageview.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(120)
      $0.width.equalTo(80)
      $0.height.equalTo(80)
    }
    imageview2.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(30)
      $0.top.equalTo(imageview.snp.bottom).offset(40)
      $0.width.equalTo(15)
      $0.height.equalTo(20)
    }
    lineview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.height.equalTo(3)
      $0.top.equalTo(imageview2.snp.bottom).offset(10)
    }
    label4.snp.makeConstraints {
      $0.leading.equalTo(imageview2.snp.trailing).offset(10)
      $0.centerY.equalTo(imageview2.snp.centerY)
    }
    label1.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(35)
      $0.top.equalTo(imageview2.snp.bottom).offset(40)
    }
    text1.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(label1.snp.bottom).offset(10)
      $0.height.equalTo(36)
    }
    label2.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(35)
      $0.top.equalTo(text1.snp.bottom).offset(16)
    }
    text2.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(label2.snp.bottom).offset(10)
      $0.height.equalTo(36)
    }
    label5.snp.makeConstraints {
      $0.trailing.equalTo(text2.snp.trailing).offset(-20)
      $0.top.equalTo(text2.snp.bottom).offset(5)
    }
    label3.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(35)
      $0.top.equalTo(label5.snp.bottom).offset(10)
    }
    text3.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(label3.snp.bottom).offset(5)
      $0.height.equalTo(100)
    }
    label6.snp.makeConstraints {
      $0.trailing.equalTo(text3.snp.trailing).offset(-20)
      $0.top.equalTo(text3.snp.bottom).offset(10)
    }
    stackview.snp.makeConstraints {
      $0.leading.equalTo(60)
      $0.trailing.equalTo(-60)
      $0.bottom.equalToSuperview().offset(-80)
      $0.height.equalTo(13)
    }
    aline.snp.makeConstraints {
      $0.width.equalTo(1)
      $0.height.equalTo(13)
    }
    label7.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(label4.snp.bottom)
    }
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  @objc private func didTapLogout() {
    let alertVC = CustomAlertViewController()
    alertVC.alertLabel.text = "로그아웃 하시겠습니까?"
    //    alertVC.delegate = self
    alertVC.islogout = true
    self.present(alertVC, animated: false)
//    self.navigationController?.pushViewController(alertVC, animated: false)
  }
  @objc private func didTapExit() {
    let alertVC = CustomAlertViewController()
    alertVC.alertLabel.text = "회원 탈퇴 하시겠습니까?"
    alertVC.isRemove = true
    self.present(alertVC, animated: false)
//    self.navigationController?.pushViewController(alertVC, animated: false)
    //    alertVC.delegate = self
  }
}
