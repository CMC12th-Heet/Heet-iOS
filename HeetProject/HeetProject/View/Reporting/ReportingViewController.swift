//
//  ReportingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/01.
//

import UIKit

class ReportingViewController: UIViewController {
  var contents = ["불법 또는 규제 상품 판매", "지식재산권 침해", "나체 이미지 또는 성적 행위", "사기 또는 거짓 정보", "폭력적인 또는 공격적 내용", "자해 또는 잔인한 내용", "기타 사유"]
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "이 게시물에 대한 신고 이유를 선택해주세요."
    label.font = .systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  private let lineView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let tableview: UITableView = {
    let tableview = UITableView()
    tableview.separatorStyle = .none
    return tableview
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "다음", style: .done, target: self, action: #selector(didComplete))
    self.navigationController?.navigationBar.topItem?.title = "신고하기"
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.title = ""
    self.tabBarController?.tabBar.isHidden = true
    setConstraint()
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(ReportingCell.self, forCellReuseIdentifier: "ReportingCell")
  }
  @objc private func didComplete() {
    let vc = CompletedReportViewController()
    self.navigationController?.pushViewController(vc, animated: false)
  }
  private func setConstraint() {
    [titleLabel, lineView, tableview]
      .forEach {
        view.addSubview($0)
      }
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(30)
      $0.top.equalToSuperview().offset(128)
    }
    lineView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(2)
    }
    tableview.snp.makeConstraints {
      $0.top.equalTo(lineView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.height.equalTo(400)
    }
  }
}
extension ReportingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReportingCell") as? ReportingCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.label.text = contents[indexPath.row]
    cell.setConstraint()
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("index \(indexPath.row)")
    tableView.reloadData()
    let cell = tableView.cellForRow(at: indexPath) as? ReportingCell
    cell?.label.textColor = ColorManager.BackgroundColor
  }
}
