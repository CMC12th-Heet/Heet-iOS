//
//  ChattingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//

import UIKit

class ChattingViewController: UIViewController {
  private let tableview: UITableView = {
    let tableview = UITableView()
    return tableview
  }()
  private let bottomview: UIView = {
    let view = UIView()
    return view
  }()
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "chatprofile"))
    imageview.layer.cornerRadius = 20
    return imageview
  }()
  private let textview: UITextView = {
    let textview = UITextView()
    textview.text = "댓글 달기.."
    textview.layer.cornerRadius = 15
    textview.backgroundColor = .systemGray4
    return textview
  }()
  func setContraints() {
    [tableview, bottomview, imageview, textview]
      .forEach {
        view.addSubview($0)
      }
    tableview.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalTo(bottomview.snp.top)
    }
    bottomview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      $0.height.equalTo(50)
    }
    imageview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.centerY.equalTo(bottomview.snp.centerY)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    textview.snp.makeConstraints {
      $0.leading.equalTo(imageview.snp.trailing).offset(10)
      $0.trailing.equalTo(bottomview.snp.trailing).offset(-10)
      $0.top.equalTo(imageview.snp.top)
      $0.height.equalTo(33)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(ChattingCell.self, forCellReuseIdentifier: ChattingCell.identifier)
    setContraints()
  }
  
  func initNotification() {
    // 키보드 올라올 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    // 키보드 내려갈 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  // 키보드 올라오기
  @objc func keyboardWillShow(noti: Notification) {
    let notiInfo = noti.userInfo!
    // 키보드 높이를 가져옴
    let keyboardFrame = notiInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    let height = keyboardFrame.size.height - self.view.safeAreaInsets.bottom
    //      sendViewBottomMargin.constant = height
    print("hihi")
    bottomview.snp.makeConstraints {
      $0.bottomMargin.equalTo(height)
    }
    // 애니메이션 효과를 키보드 애니메이션 시간과 동일하게
    let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    UIView.animate(withDuration: animationDuration) {
      self.view.layoutIfNeeded()
    }
  }
  
  // 키보드 내려가기
  @objc func keyboardWillHide(noti: Notification) {
    let notiInfo = noti.userInfo!
    let animationDuration = notiInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    //      self.sendViewBottomMargin.constant = 0
    
    // 애니메이션 효과를 키보드 애니메이션 시간과 동일하게
    UIView.animate(withDuration: animationDuration) {
      self.view.layoutIfNeeded()
    }
  }
}
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableview.dequeueReusableCell(withIdentifier: ChattingCell.identifier) as? ChattingCell else { return UITableViewCell() }
    cell.setConstraints()
    return cell
  }
}
