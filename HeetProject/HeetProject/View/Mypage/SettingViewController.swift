//
//  SettingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class SettingViewController: UIViewController {
  private let tableview: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  private let stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .vertical
    stackview.distribution = .equalSpacing
    return stackview
  }()
  private let label1: UILabel = {
    let label = UILabel()
    label.text = "V.1.0.0"
    label.font = .systemFont(ofSize: 11, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.text = "HEET"
    label.font = .systemFont(ofSize: 11, weight: .bold)
    label.textColor = ColorManager.grayColor
    return label
  }()
  private let label3: UILabel = {
    let label = UILabel()
    label.text = "문의 및 건의: makeideastrue1@gmail.com"
    label.font = .systemFont(ofSize: 11, weight: .bold)
    label.textColor = ColorManager.grayColor
    return label
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.topItem?.title = "설정"
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    [tableview, stackview]
      .forEach {
        view.addSubview($0)
      }
    stackview.addArrangedSubview(label1)
    stackview.addArrangedSubview(label2)
    stackview.addArrangedSubview(label3)
    tableview.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.leading.equalToSuperview().offset(5)
      $0.trailing.equalToSuperview().offset(-5)
      $0.height.equalTo(130)
    }
    stackview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(35)
      $0.trailing.equalToSuperview().offset(-35)
      $0.bottom.equalToSuperview().offset(100)
      $0.height.equalTo(100)
    }
  }
}
extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") else { return UITableViewCell() }
    switch indexPath.row {
    case 0: cell.textLabel?.text = "프로필 수정"
    case 1: cell.textLabel?.text = "회사 소개"
    case 2: cell.textLabel?.text = "약관"
    default: break
    }
    cell.selectionStyle = .none
    cell.textLabel?.textColor = .gray
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0: self.navigationController?.pushViewController(EditProfileViewController(), animated: false)
    case 1: self.navigationController?.pushViewController(WritingViewController(), animated: false)
    case 2: self.navigationController?.pushViewController(WritingViewController(), animated: false)
    default: break
    }
  }
}
