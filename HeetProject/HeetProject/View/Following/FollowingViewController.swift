//
//  FollowingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/24.
//

import UIKit
import Alamofire

class FollowingViewController: UIViewController {
  var postModel: Post?
  private let followerButton: UIButton = {
    let button = UIButton()
    button.setTitle("팔로잉 목록", for: .normal)
    button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
    button.tintColor = .white
    button.backgroundColor = .black
    button.layer.cornerRadius = 15
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.addTarget(self, action: #selector(didTapFollowing), for: .touchDown)
    return button
  }()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(FollowPostCell.self, forCellReuseIdentifier: FollowPostCell.identifier)
    return tableView
  }()
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
    self.tabBarController?.tabBar.backgroundColor = .systemGray6
    AF.request(Resource.baseURL + "/post/following",
               method: .get,
               parameters: nil,
               encoding: JSONEncoding(),
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .responseDecodable(of: Post.self) { response in
      switch response.result {
      case .success(let data):
        self.postModel = data
        self.tableView.reloadData()
      case .failure(let error):
        print("err \(error)")
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(FollowPostCell.self, forCellReuseIdentifier: FollowPostCell.identifier)
    self.view.backgroundColor = .white
    [followerButton, tableView]
      .forEach {
        view.addSubview($0)
      }
    followerButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(70)
      $0.width.equalTo(156)
      $0.height.equalTo(30)
      $0.centerX.equalToSuperview()
    }
    tableView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(followerButton.snp.bottom).offset(22)
      $0.height.equalTo(1000)
      $0.bottom.equalToSuperview()
    }
  }
  @objc private func didTapFollowing() {
    self.navigationController?.pushViewController(FollowingListViewController(), animated: false)
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = true
  }
}
extension FollowingViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postModel?.posts?.count ?? 3
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FollowPostCell.identifier) as? FollowPostCell else { return UITableViewCell() }
    cell.postModel = self.postModel?.posts?[indexPath.row]
    cell.imageview.loadImage(urlString: self.postModel?.posts?[indexPath.row].file_url?.components(separatedBy: ";").first ?? "https://heet-storage.s3.ap-northeast-2.amazonaws.com/1679710307826files.jpg")
    cell.setConstraint()
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}
