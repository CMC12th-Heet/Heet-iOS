//
//  WritingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/01.
//

import UIKit
import SnapKit
import ExpyTableView
import Alamofire
import CoreGraphics

var isComplete = 0
class WritingViewController: UIViewController, sendDelegate {
  func pop() {
    self.navigationController?.popViewController(animated: true)
  }
  var isOpened1 = false
  var isOpened2 = false
  var imageNames: [UIImage] = []
  var index: Int = 0
  let arraySection0: Array<String> = ["", "누구와 함께해요!", "이런 날 방문해요!", "이동 꿀팁", "주문 꿀팁", "기타 꿀팁"]
  let arraySection1: Array<String> = ["", "ex) 같이 간 사람/가고 싶은 사람","ex) 생일/기념일/기분 꿀꿀한 날","ex) 3번 출구 바로 앞 골목이 지름길!","ex) 시그니처 라떼는 필수입니다.", "ex) 화장실 문고리 잘 흔들려요!"]
  
  private let totalScrollview: UIScrollView = {
    let scrollview = UIScrollView()
    return scrollview
  }()
  private let totalview: UIView = {
    let view = UIView()
    return view
  }()
  private let addressButton: UIButton = {
    let button = UIButton()
    button.setTitle("주소를 등록해주세요", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setImage(UIImage(named: "wsearch"), for: .normal)
    button.layer.cornerRadius = 15
    button.backgroundColor = .systemGray4
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapAddress), for: .touchDown)
    return button
  }()
  @objc func didTapAddress() {
    let vc = SearchingAddressViewController()
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true)
  }
  private let shareButton: UIButton = {
    let button = UIButton()
    button.setTitle("꿀팁 정보들 공유하기", for: .normal)
    button.setImage(UIImage(named: "triR"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.layer.cornerRadius = 15
    button.backgroundColor = .gray
    button.tintColor = .white
    button.addTarget(self, action: #selector(didtapshare), for: .touchDown)
    return button
  }()
  @objc private func didtapshare() {
    isOpened1 ? tableview.expand(0) : tableview.collapse(0)
    isOpened1.toggle()
  }
  private let checkButton: UIButton = {
    let button = UIButton()
    button.setTitle("만족도 체크하기", for: .normal)
    button.setImage(UIImage(named: "triR"), for: .normal)
    button.layer.cornerRadius = 15
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.backgroundColor = .gray
    button.tintColor = .white
    button.addTarget(self, action: #selector(didtapCheck), for: .touchDown)
    return button
  }()
  @objc private func didtapCheck() {
    isOpened2 ? tableview.expand(1) : tableview.collapse(1)
    isOpened2.toggle()
  }
  private let titleText: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "제목"
    textfield.font = .systemFont(ofSize: 17, weight: .bold)
    return textfield
  }()
  private let subTitleText: UITextField = {
    let textfield = UITextField()
    textfield.placeholder = "소제목"
    textfield.font = .systemFont(ofSize: 12, weight: .bold)
    return textfield
  }()
  private let contentText: UITextView = {
    let textview = UITextView()
    textview.text = "내용을 입력하세요"
    textview.font = .systemFont(ofSize: 14)
    return textview
  }()
  private let stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .vertical
    stackview.distribution = .equalSpacing
    stackview.spacing = 6
    return stackview
  }()
  lazy private var scrollview: UIScrollView = {
    let scrollview = UIScrollView()
    scrollview.frame = UIScreen.main.bounds
    scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageNames.count), height: 268)
    scrollview.delegate = self
    scrollview.alwaysBounceVertical = false
    scrollview.showsHorizontalScrollIndicator = false
    scrollview.showsVerticalScrollIndicator = false
    scrollview.isScrollEnabled = true
    scrollview.isPagingEnabled = true
    scrollview.bounces = false
    return scrollview
  }()
  private let line1: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line1")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line2: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line1")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line3: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line2")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line4: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line2")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let tableview: ExpyTableView = {
    let tableview = ExpyTableView()
    tableview.separatorStyle = .none
    return tableview
  }()
  private let tagText: UITextField = {
    let textField = UITextField()
    textField.textColor = .gray
    textField.placeholder = "# 태그하기"
    return textField
  }()
  private let collectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  private let redLabel: UILabel = {
    let label = UILabel()
    label.text = "*공유하고 싶은 꿀팁을 눌러 활성화하세요."
    label.font = .systemFont(ofSize: 9, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    isComplete = 0
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.backItem?.title = ""
    self.addressButton.setTitle(storeTotal, for: .normal)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    addressButton.setTitle("주소를 등록해주세요", for: .normal)
    view.backgroundColor = .white
    tableview.register(ShareCell.self, forCellReuseIdentifier: ShareCell.identifier)
    tableview.register(CheckedCell.self, forCellReuseIdentifier: CheckedCell.identifier)
    tableview.delegate = self
    tableview.dataSource = self
    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.navigationBar.topItem?.title = "우리동네 기록"
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = ""
    let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(didTapComplete))
    self.navigationController?.navigationBar.topItem?.rightBarButtonItem = button
    self.navigationController?.navigationBar.topItem?.backAction = UIAction(handler: { action in
      if isComplete == 0 {
        let vc = CustomAlertViewController()
        vc.delegate = self
        self.present(vc, animated: true)
      } else if isComplete == 1 {
        self.navigationController?.popViewController(animated: false)
      }
    })
    setConstraint()
  }
  @objc private func didTapComplete() {
    let parameters: [String : Any] = [
      "title": self.titleText.text ?? "",
      "mini_title": self.subTitleText.text ?? "",
      "content": self.contentText.text ?? "",
      "store_id": stId ?? 1,
      "satisfaction": selectedFace,
      "together_with": cellText1 ?? "",
      "perfect_day": cellText2 ?? "",
      "moving_tip": cellText3 ?? "",
      "ordering_tip": cellText4 ?? "",
      "other_tips": cellText5 ?? ""
    ]
    AF.upload(multipartFormData: { multipartFormData in
      for (key, value) in parameters {
        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
      }
      for images in self.imageNames {
        let imgData = images.jpegData(compressionQuality: 1)
        multipartFormData.append(imgData!, withName: "files", fileName: "files.jpg", mimeType: "image/jpg")
      }
    }, to: "http://15.165.130.99:3000/post", method: .post, headers: [
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"
    ])
    .response { response in
      print("rereree \(response.response?.description)")
      isComplete = 1
      self.navigationController?.popViewController(animated: false)
    }
  }
  private func setConstraint() {
    self.view.addSubview(totalScrollview)
    totalScrollview.addSubview(totalview)
    [addressButton, scrollview, stackview, tableview]
      .forEach {
        totalview.addSubview($0)
      }
    [line1, titleText, line2, subTitleText, line3, contentText, line4]
      .forEach {
        stackview.addArrangedSubview($0)
      }
    totalScrollview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    totalview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.width.equalTo(totalScrollview.snp.width)
    }
    tableview.snp.makeConstraints {
      $0.top.equalTo(line4.snp.bottom).offset(5)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(600)
      $0.bottom.equalToSuperview()
    }
    stackview.snp.makeConstraints {
      $0.leading.equalTo(totalview.snp.leading).offset(20)
      $0.trailing.equalTo(totalview.snp.trailing).offset(-20)
      $0.top.equalTo(scrollview.snp.bottom).offset(3)
      $0.height.equalTo(200)
    }
    contentText.snp.makeConstraints {
      $0.height.equalTo(100)
    }
    addressButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.centerX.equalTo(totalview.snp.centerX)
      $0.width.equalTo(175)
      $0.height.equalTo(30)
    }
    scrollview.snp.makeConstraints {
      $0.top.equalTo(addressButton.snp.bottom).offset(20)
      $0.leading.equalTo(totalview.snp.leading)
      $0.trailing.equalTo(totalview.snp.trailing)
      $0.height.equalTo(268)
    }
    for (index, imageName) in imageNames.enumerated() {
      print("size \(imageName.size)")
//      let resize = imageName.resizeWithWidth(width: CGFloat(Int(view.bounds.width)-40))
      let imageView = UIImageView(image: imageName)
      imageView.contentMode = .scaleToFill
      let button = UIButton()
      button.setTitle("\(index+1)/\(imageNames.count)", for: .normal)
      button.setTitleColor(.black, for: .normal)
      button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
      button.backgroundColor = .white
      button.layer.cornerRadius = 10
      let positionX = Int(self.scrollview.bounds.width) * index + 20
      imageView.frame = CGRect(x: positionX, y: 0, width: Int(view.bounds.width)-40, height: 268)
      imageView.clipsToBounds = true
      imageView.layer.cornerRadius = 10
      scrollview.addSubview(imageView)
      imageView.addSubview(button)
      button.snp.makeConstraints {
        $0.trailing.equalToSuperview().offset(-10)
        $0.bottom.equalToSuperview().offset(-10)
        $0.width.equalTo(50)
      }
    }
  }
}
extension WritingViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
  func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
    switch state {
    case .willExpand:
      print("WILL EXPAND")
    case .willCollapse:
      print("WILL COLLAPSE")
    case .didExpand:
      print("DID EXPAND")
    case .didCollapse:
      print("DID COLLAPSE")
    }
  }
  func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
    return true
  }
  func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.backgroundColor = .clear
    cell.selectionStyle = .none
    if section == 0 {
      cell.contentView.addSubview(shareButton)
      cell.contentView.addSubview(redLabel)
      shareButton.snp.makeConstraints {
        $0.centerY.equalToSuperview().offset(-10)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(146)
        $0.height.equalTo(28)
      }
      redLabel.snp.makeConstraints {
        $0.top.equalTo(shareButton.snp.bottom).offset(3)
        $0.centerX.equalToSuperview()
      }
    } else if section == 1 {
      cell.contentView.addSubview(checkButton)
      checkButton.snp.makeConstraints {
        $0.centerY.equalToSuperview().offset(-10)
        $0.centerX.equalToSuperview()
        $0.width.equalTo(146)
        $0.height.equalTo(28)
      }
    }
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 6
    } else if section == 1 {
      return 2
    } else {
      return 1
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell1 = tableView.dequeueReusableCell(withIdentifier: ShareCell.identifier) as? ShareCell else { return UITableViewCell() }
    guard let cell2 = tableView.dequeueReusableCell(withIdentifier: CheckedCell.identifier) as? CheckedCell else { return UITableViewCell() }
    if indexPath.section == 0 {
      cell1.cellIndex = indexPath.row
      cell1.selectionStyle = .none
      cell1.cellButton.setTitle(arraySection0[indexPath.row], for: .normal)
      cell1.cellText.placeholder = arraySection1[indexPath.row]
      cell1.setConstraints()
      cell1.cellText.delegate = self
      return cell1
    } else if indexPath.section == 1 {
      cell2.selectionStyle = .none
      cell2.setConstraints()
      return cell2
    } else {
      return cell1
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 80
    } else if indexPath.section == 0 {
      return 40
    } else {
      return 100
    }
  }
}
extension WritingViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
  }
}
