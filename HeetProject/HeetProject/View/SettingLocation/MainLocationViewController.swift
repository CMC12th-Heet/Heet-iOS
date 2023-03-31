//
//  MainLocationViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/23.
//

import UIKit
import SnapKit
import ExpyTableView

class MainLocationViewController: UIViewController {
  static var selectedGu = "서초구"
  static var selectedCity = "서울"
  static var temp = [""]
  static var city = ""
  var array1 = ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
  var array2 = ["가평군", "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "양평군", "여주시", "연천군", "여주시", "연천군", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
  var array3 = ["중구", "동구", "미추홀구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "옹진군"]
  var data: dataProtocol?
  private let mylabel: UILabel = {
    let label = UILabel()
    label.text = "내가 설정한 동네"
    label.font = .systemFont(ofSize: 14)
    return label
  }()
  static var myTownLabel: UILabel = {
    let label = UILabel()
    label.text = "서울 서초구"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  private let tableview: ExpyTableView = {
    let tableview = ExpyTableView()
    tableview.separatorStyle = .none
    return tableview
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "현재 거주지를 알려주세요"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  let localStackview: UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .horizontal
    stackview.alignment = .center
    stackview.distribution = .equalSpacing
    stackview.spacing = 10
    return stackview
  }()
  private let completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("설정 완료", for: .normal)
    button.layer.cornerRadius = 30
    button.backgroundColor = ColorManager.BackgroundColor
    button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
    button.addTarget(self, action: #selector(didTapComplete), for: .touchDown)
    return button
  }()
  static var local1: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    button.setTitle("", for: .normal)
    button.setImage(UIImage(named: "basiccheck"), for: .normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = .systemGray6
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.isHidden = true
    return button
  }()
  static var local2: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 84, height: 30))
    button.setTitle("", for: .normal)
    button.setImage(UIImage(named: "basiccheck"), for: .normal)
    button.layer.cornerRadius = 10
    button.backgroundColor = .systemGray6
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.isHidden = true
    return button
  }()
  @objc private func didTapComplete() {
    self.navigationController?.popViewController(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(LocationCell.self, forCellReuseIdentifier: LocationCell.identifier)
    self.tabBarController?.tabBar.isHidden = true
    view.backgroundColor = .white
    self.navigationItem.title = "동네 설정하기"
    self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    setConstraint()
  }
  private func setConstraint() {
    [titleLabel, localStackview, completeButton, tableview, mylabel, MainLocationViewController.myTownLabel, localStackview]
      .forEach { view.addSubview($0) }
    localStackview.addArrangedSubview(MainLocationViewController.local1)
    localStackview.addArrangedSubview(MainLocationViewController.local2)
    MainLocationViewController.local1.snp.makeConstraints {
      $0.width.equalTo(84)
      $0.height.equalTo(30)
    }
    MainLocationViewController.local2.snp.makeConstraints {
      $0.width.equalTo(84)
      $0.height.equalTo(30)
    }
    //    LocationViewController.local3.snp.makeConstraints {
    //      $0.width.equalTo(84)
    //      $0.height.equalTo(30)
    //    }
    mylabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(28)
      $0.top.equalToSuperview().offset(120)
    }
    MainLocationViewController.myTownLabel.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-30)
      $0.top.equalToSuperview().offset(121)
    }
    localStackview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(28)
      $0.top.equalTo(mylabel.snp.bottom).offset(20)
    }
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(28)
      $0.top.equalTo(localStackview.snp.bottom).offset(10)
    }
    tableview.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalTo(completeButton.snp.top)
    }
    completeButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
      $0.height.equalTo(60)
      $0.width.equalTo(350)
    }
  }
}
extension MainLocationViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
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
    cell.selectionStyle = .none
    switch section {
    case 0:
      cell.textLabel?.text = "서울"
    case 1: cell.textLabel?.text = "경기"
    case 2: cell.textLabel?.text = "인천"
    default: cell.textLabel?.text = "인천"
    }
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier) as? LocationCell else { return UITableViewCell() }
    switch indexPath.section {
    case 0: cell.data = array1
    case 1: cell.data = array2
    case 2: cell.data = array3
    default: cell.data = array1
    }
    cell.isMainLocation = true
    cell.setConstraints()
    return cell
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      MainLocationViewController.selectedCity = "서울"
      MainLocationViewController.local1.setTitle("서울", for: .normal)
    } else if indexPath.section == 1 {
      MainLocationViewController.selectedCity = "경기"
      MainLocationViewController.local1.setTitle("경기", for: .normal)
    } else {
      MainLocationViewController.selectedCity = "인천"
      MainLocationViewController.local1.setTitle("인천", for: .normal)
    }
    MainLocationViewController.local1.isHidden = false
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 45
  }
}
