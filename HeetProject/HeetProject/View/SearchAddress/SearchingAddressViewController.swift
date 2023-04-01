//
//  SearchingAddressViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit
import Alamofire

var storeTotal = "주소를 등록해주세요"
class SearchingAddressViewController: UIViewController {
  var storeUrl = ""
  var storeAddress = ""
  private let label: UILabel = {
    let label = UILabel()
    label.text = "가게명+동네명\nex) 이디야 논현점/버거킹 논현점..\n\n주소\nex) 서울시 강남구 00로..\n\n동네명\nex) 경기도 용인시 수지구.. "
    label.textColor = .gray
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  private let resultLabel: UILabel = {
    let label = UILabel()
    label.text = "검색 결과"
    return label
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "우리동네 기록"
    return label
  }()
  private let tableview: UITableView = {
    let tableview = UITableView()
    tableview.isHidden = true
    return tableview
  }()
  private let exitButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "xMark"), for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapExit), for: .touchDown)
    return button
  }()
  private let completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("등록", for: .normal)
    button.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    button.addTarget(self, action: #selector(didTapComplete), for: .touchDown)
    return button
  }()
  @objc private func didTapExit() {
    self.dismiss(animated: true)
  }
  @objc private func didTapComplete() {
    var chooseItem: Parameters = [
      "name": storeTotal,
      "url": storeUrl,
      "address": storeAddress
    ]
    AF.request(Resource.baseURL + "/store",
               method: .post,
               parameters: chooseItem,
               encoding: JSONEncoding.default,
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .responseDecodable(of: StoreIdModel.self) { response in
      switch response.result {
      case .success(let response):
        stId = response.store_id
        print("locaaal \(response)")
        self.dismiss(animated: true)
      case .failure(let error):
        print("errr \(error)")
        self.dismiss(animated: true)
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(AddressCell.self, forCellReuseIdentifier: AddressCell.identifier)
    [exitButton, completeButton, label, titleLabel, tableview, resultLabel]
      .forEach {
        view.addSubview($0)
      }
    resultLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(100)
      $0.leading.equalToSuperview().offset(40)
    }
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(17)
      $0.centerX.equalToSuperview()
    }
    exitButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(27)
      $0.centerY.equalTo(self.titleLabel.snp.centerY)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    completeButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().offset(-27)
      $0.centerY.equalTo(self.titleLabel.snp.centerY)
      $0.width.equalTo(50)
      $0.height.equalTo(50)
    }
    label.snp.makeConstraints {
      $0.top.equalToSuperview().offset(200)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(200)
    }
    view.addSubview(tableview)
    tableview.snp.makeConstraints {
      $0.top.equalTo(resultLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview()
    }
    setSearchBar()
  }
  func setSearchBar() {
    let searchBar = UISearchBar()
    searchBar.placeholder = "위치 검색"
    searchBar.layer.cornerRadius = 80
    searchBar.delegate = self
    self.view.addSubview(searchBar)
    searchBar.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(40)
    }
    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
      textfield.backgroundColor = .systemGray2
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
      textfield.textColor = .black
      if let leftView = textfield.leftView as? UIImageView {
        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
        leftView.tintColor = UIColor.white
      }
      if let rightView = textfield.rightView as? UIImageView {
        rightView.image = rightView.image?.withRenderingMode(.alwaysTemplate)
        rightView.tintColor = UIColor.white
        rightView.backgroundColor = .white
      }
    }
  }
}
extension SearchingAddressViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return storeList?.count ?? 10
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier) as? AddressCell else { return UITableViewCell() }
    cell.setConstraint()
    cell.label1.text = storeList?[indexPath.row].place_name
    cell.label2.text = storeList?[indexPath.row].address_name
    cell.selectionStyle = .none
    cell.isMultipleTouchEnabled = false
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    tableview.isHidden = false
    label.isHidden = true
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as? AddressCell
    cell?.label1.textColor = ColorManager.BackgroundColor
    storeTotal = storeList?[indexPath.row].place_name ?? ""
    storeUrl = storeList?[indexPath.row].place_url ?? ""
    storeAddress = storeList?[indexPath.row].address_name ?? ""
    print(storeTotal, storeUrl, storeAddress)
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let parameters: Parameters = [
      "keyword": searchText
    ]
    NetworkService.shared.requestData(
      url: "/store",
      method: .get,
      params: parameters,
      headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
      parameters: URLEncoding.queryString,
      model: [StoreModel].self) { response in
        switch response {
        case .success(let t):
          if let t = t as? [StoreModel] {
            storeList = t
            self.tableview.isHidden = false
            self.label.isHidden = true
            self.resultLabel.isHidden = false
            self.tableview.reloadData()
          }
        default: break
        }
      }
  }
}
