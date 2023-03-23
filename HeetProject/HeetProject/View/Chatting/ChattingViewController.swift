//
//  ChattingViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//

import UIKit
import Alamofire

class ChattingViewController: UIViewController {
  var chatId: Int?
  var chatModel: [ChattingModel]?
  private let tableview: UITableView = {
    let tableview = UITableView()
    tableview.separatorStyle = .none
    return tableview
  }()
  private let bottomview: UIView = {
    let view = UIView()
    return view
  }()
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "chatprofile"))
    imageview.layer.cornerRadius = 10
    imageview.clipsToBounds = true
    return imageview
  }()
  private let textview: UITextView = {
    let textview = UITextView()
    textview.text = "댓글 달기.."
    textview.textColor = .white
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
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    textview.delegate = self
    self.navigationController?.navigationBar.backItem?.title = ""
    self.navigationController?.navigationBar.topItem?.title = "댓글"
    tableview.delegate = self
    tableview.dataSource = self
    tableview.register(ChattingCell.self, forCellReuseIdentifier: ChattingCell.identifier)
    setContraints()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    NetworkService().getMainPost(url: "/comment/\(self.chatId!)",
                                 method: .get,
                                 params: nil,
                                 headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                 model: [ChattingModel].self) { response in
      switch response.result {
      case .success(let response):
        self.chatModel = response
        self.tableview.reloadData()
      case .failure(let error):
        print("error \(error)")
      }
    }
  }
  func initNotification() {
    // 키보드 올라올 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    // 키보드 내려갈 때
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
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
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    .delete
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chatModel?.count ?? 3
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        if (UserDefaults.standard.string(forKey: "email")! == chatModel?[indexPath.row].user?.email) {
        print("de \(self.chatModel?[indexPath.row].comment_id ?? 0)")
          AF.request(Resource.baseURL + "/comment/\(self.chatModel?[indexPath.row].comment_id ?? 0)", method: .delete,
                     parameters: nil,
                     encoding: URLEncoding.queryString,
                     headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
          .validate()
          .response { response in
            print("delete")
            print("re \(response)")
            NetworkService().getMainPost(url: "/comment/\(self.chatId!)",
                                         method: .get,
                                         params: nil,
                                         headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                         model: [ChattingModel].self) { response in
              switch response.result {
              case .success(let response):
                self.chatModel = response
                self.tableview.reloadData()
              case .failure(let error):
                print("error \(error)")
              }
            }
//            self.tableview.reloadData()
          }
        }
      }
    print("hhhh")
  }
  func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    print("scccc")
    return UISwipeActionsConfiguration()
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableview.dequeueReusableCell(withIdentifier: ChattingCell.identifier) as? ChattingCell else { return UITableViewCell() }
    cell.message.text = chatModel?[indexPath.row].content
    cell.username.text = chatModel?[indexPath.row].user?.username
    cell.setConstraints()
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
extension ChattingViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == "\n" {
      textView.resignFirstResponder()
      let body: Parameters = [
        "content": "\(textView.text ?? "")"
      ]
      AF.request(Resource.baseURL + "/comment/\(self.chatId!)",
                 method: .post,
                 parameters: body,
                 encoding: JSONEncoding(),
                 headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
      .validate()
      .response(completionHandler: { response in
        switch response.result {
        case .success(_):
          NetworkService().getMainPost(url: "/comment/\(self.chatId!)",
                                       method: .get,
                                       params: nil,
                                       headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                       model: [ChattingModel].self) { response in
            switch response.result {
            case .success(let response):
              self.chatModel = response
              self.tableview.reloadData()
            case .failure(let error):
              print("error \(error)")
            }
          }
        case .failure(let error):
          print("err \(error)")
        default: break
        }
      })
      return false
    }
    return true
  }
}
