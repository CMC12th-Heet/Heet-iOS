//
//  SearchingAddressViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit

class SearchingAddressViewController: UIViewController {
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
    button.setImage(UIImage(named: "profile"), for: .normal)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapExit), for: .touchDown)
    return button
  }()
  private let completeButton: UIButton = {
    let button = UIButton()
    button.setTitle("등록", for: .normal)
    button.titleLabel?.textColor = ColorManager.BackgroundColor
    button.addTarget(self, action: #selector(didTapComplete), for: .touchDown)
    return button
  }()
  @objc private func didTapExit() {
    self.dismiss(animated: true)
  }
  @objc private func didTapComplete() {
    
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
      $0.trailing.equalToSuperview()
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(17)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
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
    searchBar.layer.cornerRadius = 40
    //왼쪽 서치아이콘 이미지 세팅하기
    //    searchBar.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
    //    //오른쪽 x버튼 이미지 세팅하기
    //    searchBar.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)
    //    //네비게이션에 서치바 넣기
    searchBar.delegate = self
    self.view.addSubview(searchBar)
    searchBar.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(40)
    }
    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
      //서치바 백그라운드 컬러
      textfield.backgroundColor = .systemGray2
      //플레이스홀더 글씨 색 정하기
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
      //서치바 텍스트입력시 색 정하기
      textfield.textColor = .black
      //왼쪽 아이콘 이미지넣기
      if let leftView = textfield.leftView as? UIImageView {
        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
        //이미지 틴트컬러 정하기
        leftView.tintColor = UIColor.white
      }
      //오른쪽 x버튼 이미지넣기
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
    return 20
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.identifier) as? AddressCell else { return UITableViewCell() }
    cell.setConstraint()
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
  }
}
