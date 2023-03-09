//
//  FollowingListViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class FollowingListViewController: UIViewController {
  var index = 0
  private let lineview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "dfdf"))
    return imageview
  }()
  private let tableview: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.isHidden = false
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
    return 10
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowCell.identifier, for: indexPath) as? FollowCell else { return UITableViewCell() }
    cell.setConstraint()
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}
