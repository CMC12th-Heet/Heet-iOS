//
//  FollowingListViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit
import Alamofire

class FollowingListViewController: UIViewController {
  var index = 0
  var users: [User]?
  private let lineview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "line1"))
    return imageview
  }()
  private let tableview: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AF.request(Resource.baseURL + "/user/following",
               method: .get,
               parameters: nil,
               encoding: JSONEncoding(),
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .responseDecodable(of: [User].self) { response in
      switch response.result {
      case .success(let data):
        self.users = data
        self.tableview.reloadData()
      case .failure(let error):
        print("err \(error)")
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.backItem?.title = ""
    self.navigationController?.navigationBar.backItem?.titleView?.tintColor = .black
    self.navigationController?.navigationBar.isHidden = false
    self.tabBarController?.tabBar.isHidden = true
    if index == 0 {
      navigationController?.navigationBar.topItem?.title = "팔로잉"
    } else {
      navigationController?.navigationBar.topItem?.title = "팔로워"
    }
    tableview.dataSource = self
    tableview.delegate = self
    tableview.register(FollowCell.self, forCellReuseIdentifier: FollowCell.identifier)
    [lineview, tableview]
      .forEach {
        view.addSubview($0)
      }
    lineview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(90)
    }
    tableview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(lineview.snp.bottom).offset(10)
      $0.height.equalTo(1000)
    }
  }
}
extension FollowingListViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users?.count ?? 3
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowCell.identifier, for: indexPath) as? FollowCell else { return UITableViewCell() }
    cell.nickname.text = self.users?[indexPath.row].username
    cell.id = self.users?[indexPath.row].user_id
    cell.setConstraint()
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}
