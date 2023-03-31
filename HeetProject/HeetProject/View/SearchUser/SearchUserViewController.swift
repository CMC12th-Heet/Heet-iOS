//
//  SearchUserViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/24.

import UIKit
import Alamofire

class SearchUserViewController: UIViewController {
  var userModel: [User]?
  let borderView: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "line1"))
    return imageview
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "유저\nex) HEET_USER0318"
    label.textColor = .gray
    label.textAlignment = .center
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "유저 찾기"
    label.font = .systemFont(ofSize: 17)
    return label
  }()
  private let resultLabel: UILabel = {
    let label = UILabel()
    label.text = "찾고자 하는 유저를 검색해보세요"
    label.font = .systemFont(ofSize: 13)
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
  @objc private func didTapExit() {
    self.dismiss(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
    [exitButton, label, tableview, resultLabel, borderView, titleLabel]
      .forEach {
        view.addSubview($0)
      }
    titleLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().offset(50)
    }
    resultLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(75)
      $0.leading.equalToSuperview().offset(40)
    }
    exitButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(27)
      $0.centerY.equalTo(self.titleLabel.snp.centerY)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    label.snp.makeConstraints {
      $0.top.equalTo(borderView.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    borderView.snp.makeConstraints {
      $0.height.equalTo(3)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(resultLabel.snp.bottom).offset(10)
    }
    tableview.snp.makeConstraints {
      $0.top.equalTo(borderView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(10)
      $0.trailing.equalToSuperview().offset(-10)
      $0.bottom.equalToSuperview()
    }
    setSearchBar()
  }
  func setSearchBar() {
    let searchBar = UISearchBar()
    searchBar.placeholder = "유저 검색"
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
extension SearchUserViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userModel?.count ?? 3
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else { return UITableViewCell() }
    cell.label1.text = userModel?[indexPath.row].username
    cell.setConstraint()
    cell.selectionStyle = .none
    cell.isMultipleTouchEnabled = false
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 65
  }
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    resultLabel.text = "검색 결과"
    tableview.isHidden = false
    label.isHidden = true
  }
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let parameters: Parameters = [
      "keyword": searchText
    ]
    AF.request(Resource.baseURL + "/user/search",
               method: .get,
               parameters: parameters,
               encoding: URLEncoding.queryString,
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .responseDecodable(of: [User].self) { response in
      switch response.result {
      case .success(let response):
        print(">>>> resres \(response)")
        self.userModel = response
        self.tableview.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
}
