//
//  DetailViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//
import UIKit
import SnapKit
import ExpyTableView
import Alamofire

class DetailViewController: UIViewController {
  var model: [String] = ["a"]
  var isOpened1 = false
  var isOpened2 = false
  var id: Int = 0
  var ismyPost: Int?
  var satisfy: Int?
  var imageNames: [String] = []
  let arraySection0: Array<String> = ["", "누구와 함께해요!", "이런 날 방문해요!", "이동 꿀팁", "주문 꿀팁", "기타 꿀팁"]
  let arraySection1: Array<String> = ["", "ex) 같이 간 사람/가고 싶은 사람","ex) 생일/기념일/기분 꿀꿀한 날","ex) 3번 출구 바로 앞 골목이 지름길!","ex) 시그니처 라떼는 필수입니다.", "ex) 화장실 문고리 잘 흔들려요!"]
  
  private let totalScrollview: UIScrollView = {
    let scrollview = UIScrollView()
    return scrollview
  }()
  private let totalview: UIView = {
    let view = UIView()
    return view
  }()
  private let addressButton: UIButton = {
    let button = UIButton()
    button.setTitle("카페 702", for: .normal)
    button.setImage(UIImage(named: "wlocal"), for: .normal)
    button.layer.cornerRadius = 15
    button.backgroundColor = ColorManager.BackgroundColor
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    return button
  }()
  private let shareButton: UIButton = {
    let button = UIButton()
    button.setTitle("꿀팁 정보들", for: .normal)
    button.setImage(UIImage(named: "tri"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.layer.cornerRadius = 15
    button.backgroundColor = .black
    button.tintColor = .white
    button.addTarget(self, action: #selector(didtapshare), for: .touchDown)
    return button
  }()
  @objc private func didtapshare() {
    isOpened1 ? tableview.expand(0) : tableview.collapse(0)
    isOpened1.toggle()
  }
  private let checkButton: UIButton = {
    let button = UIButton()
    button.setTitle("만족도 체크", for: .normal)
    button.setImage(UIImage(named: "tri"), for: .normal)
    button.layer.cornerRadius = 15
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.backgroundColor = .black
    button.tintColor = .white
    button.addTarget(self, action: #selector(didtapCheck1), for: .touchDown)
    return button
  }()
  @objc private func didtapCheck1() {
    isOpened2 ? tableview.expand(1) : tableview.collapse(1)
    isOpened2.toggle()
  }
  private let titleText: UITextField = {
    let textfield = UITextField()
    textfield.text = "제목"
    textfield.textColor = .gray
    textfield.font = .systemFont(ofSize: 17, weight: .bold)
    textfield.isUserInteractionEnabled = false
    return textfield
  }()
  private let subTitleText: UITextField = {
    let textfield = UITextField()
    textfield.text = "소제목"
    textfield.font = .systemFont(ofSize: 12, weight: .bold)
    textfield.isUserInteractionEnabled = false
    return textfield
  }()
  private let contentText: UITextView = {
    let textview = UITextView()
    textview.text = "내용을 입력하세요"
    textview.font = .systemFont(ofSize: 14)
    textview.isUserInteractionEnabled = false
    return textview
  }()
  private let stackview: UIStackView = {
    let stackview = UIStackView()
    stackview.axis = .vertical
    stackview.distribution = .equalSpacing
    stackview.spacing = 6
    return stackview
  }()
  lazy private var scrollview: UIScrollView = {
    let scrollview = UIScrollView()
    //    scrollview.frame = UIScreen.main.bounds
    scrollview.frame = CGRect(x: 0, y: 0, width: Int(self.view.bounds.width)-40, height: 268)
    scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageNames.count), height: 268)
    scrollview.delegate = self
    scrollview.alwaysBounceVertical = false
    scrollview.showsHorizontalScrollIndicator = false
    scrollview.showsVerticalScrollIndicator = false
    scrollview.isScrollEnabled = true
    scrollview.isPagingEnabled = true
    scrollview.bounces = false
    return scrollview
  }()
  private let line1: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line1")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line2: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line1")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line3: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line2")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let line4: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "line2")
    imageview.contentMode = .scaleAspectFill
    imageview.frame = CGRect(x: 0, y: 0, width: 334, height: 1)
    return imageview
  }()
  private let tableview: ExpyTableView = {
    let tableview = ExpyTableView()
    tableview.separatorStyle = .none
    return tableview
  }()
  private let collectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  private let userView: UIView = {
    let view = UIView()
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    view.layer.cornerRadius = 15
    return view
  }()
  private let userImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "chatprofile"))
    imageview.layer.cornerRadius = 10
    imageview.clipsToBounds = true
    return imageview
  }()
  private let username: UILabel = {
    let label = UILabel()
    label.text = "heet_member"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private let followLabel: UILabel = {
    let label = UILabel()
    label.text = "팔로우"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private func setConstraint() {
    self.view.addSubview(totalScrollview)
    totalScrollview.addSubview(totalview)
    [addressButton, scrollview, stackview, tableview, userView, followLabel]
      .forEach {
        totalview.addSubview($0)
      }
    [userImage, username, followLabel]
      .forEach {
        userView.addSubview($0)
      }
    [line1, titleText, line2, subTitleText, line3, contentText, line4]
      .forEach {
        stackview.addArrangedSubview($0)
      }
    userImage.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(10)
      $0.width.equalTo(25)
      $0.height.equalTo(25)
    }
    username.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(userImage.snp.trailing).offset(10)
    }
    followLabel.snp.makeConstraints {
      $0.trailing.equalTo(userView.snp.trailing).offset(-20)
      $0.centerY.equalToSuperview()
    }
    totalScrollview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    totalview.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.width.equalTo(totalScrollview.snp.width)
    }
    tableview.snp.makeConstraints {
      $0.top.equalTo(line4.snp.bottom).offset(5)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(520)
    }
    stackview.snp.makeConstraints {
      $0.leading.equalTo(totalview.snp.leading).offset(20)
      $0.trailing.equalTo(totalview.snp.trailing).offset(-20)
      $0.top.equalTo(scrollview.snp.bottom).offset(3)
    }
    contentText.snp.makeConstraints {
      $0.height.equalTo(100)
    }
    addressButton.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalTo(123)
      $0.height.equalTo(30)
    }
    scrollview.snp.makeConstraints {
      $0.top.equalTo(addressButton.snp.bottom).offset(20)
      $0.leading.equalTo(totalview.snp.leading)
      $0.trailing.equalTo(totalview.snp.trailing)
      $0.height.equalTo(268)
    }
    //        for (index, imageName) in imageNames.enumerated() {
    //          let image = UIImage(named: imageName)
    //          let imageView = UIImageView(image: image)
    //          let positionX = self.view.frame.width * CGFloat(index)
    //          imageView.frame = CGRect(x: positionX, y: 0, width: scrollview.bounds.width + 40, height: scrollview.bounds.height)
    //          imageView.image = UIImage(named: imageNames[index])
    //          imageView.contentMode = .scaleAspectFit
    //          imageView.layer.cornerRadius = 20
    //          scrollview.addSubview(imageView)
    //        }
  }
  @objc private func didtapEdit() {
    let body: Parameters = [
      "title": self.titleText.text ?? "",
      "mini_title": self.subTitleText.text ?? "",
      "content": self.contentText.text ?? "",
      "satisfaction": selectedFace,
      "together_with": cellText1 ?? "",
      "perfect_day": cellText2 ?? "",
      "moving_tip": cellText3 ?? "",
      "ordering_tip": cellText4 ?? "",
      "other_tips": cellText5 ?? ""
    ]
    AF.request(Resource.baseURL + "/post/\(self.id)",
               method: .patch,
               parameters: body,
               encoding: JSONEncoding(),
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .response(completionHandler: { response in
      switch response.result {
      case .success(_):
        print("edit success!")
      case .failure(let error):
        print("error \(error)")
      }
    }
    )}
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
    self.navigationController?.navigationBar.backItem?.title = ""
    NetworkService().getMainPost(url: "/post/\(self.id)", method: .get, params: nil, headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"], model: LocalPost.self) { response in
      switch response.result {
      case .success(let response):
        self.model.append(response.together_with ?? "")
        self.model.append(response.moving_tip ?? "")
        self.model.append(response.perfect_day ?? "")
        self.model.append(response.ordering_tip ?? "")
        self.model.append(response.other_tips ?? "")
        print("m \(response)")
        print("mmm \(self.model)")
        self.titleText.text = response.title
        self.subTitleText.text = response.mini_title
        self.contentText.text = response.content
        self.addressButton.setTitle(response.store?.name, for: .normal)
        self.imageNames = response.urlList ?? [""]
        self.satisfy = response.satisfaction
        self.ismyPost = response.isMyPost
        self.username.text = response.user?.username
        DispatchQueue.main.async {
          let edit = UIAction(title: "수정하기", attributes: .keepsMenuPresented, handler: {_ in
            self.titleText.isUserInteractionEnabled = true
            self.subTitleText.isUserInteractionEnabled = true
            self.contentText.isUserInteractionEnabled = true
            let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(self.didtapEdit))
            self.navigationItem.rightBarButtonItem = button
          })
          let delete = UIAction(title: "삭제하기", attributes: .keepsMenuPresented, handler: { _ in
            AF.request(Resource.baseURL + "/post/\(self.id)", method: .delete,
                       parameters: nil,
                       encoding: URLEncoding.queryString,
                       headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
            .validate()
            .response { response in
              print("delete")
              self.navigationController?.popViewController(animated: false)
            }
          })
          var buttonMenu = UIMenu(title: "", children: [edit, delete])
          var button = UIBarButtonItem(image: UIImage(named: "more"), style: .done, target: self, action: nil)
          let report = UIAction(title: "신고하기", attributes: .keepsMenuPresented, handler: { _ in self.navigationController?.pushViewController(ReportingViewController(), animated: false) })
          print("mmm \(self.ismyPost!)")
          if self.ismyPost! == 1 {
          } else {
            buttonMenu = UIMenu(title: "", children: [report])
          }
          button.menu = buttonMenu
          self.navigationItem.rightBarButtonItem = button
          let toolbar = UIToolbar()
          self.setConstraint()
          self.view.addSubview(toolbar)
          toolbar.translatesAutoresizingMaskIntoConstraints = false
          toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
          toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
          toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: self.view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
          let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
          let toolbarItem1 = UIBarButtonItem(image: UIImage(named: "toolChat"), style: .done, target: self, action: #selector(self.didTapChat))
          let toolbarItem2 = UIBarButtonItem(image: UIImage(named: "toolScrap"), style: .done, target: self, action: nil)
          let toolbarItem3 = UIBarButtonItem(image: UIImage(named: "toolShare"), style: .done, target: self, action: nil)
          toolbarItem1.tintColor = .gray
          toolbarItem2.tintColor = .gray
          toolbarItem3.tintColor = .gray
          toolbar.setItems([toolbarItem1, toolbarItem2, flexibleItem, toolbarItem3], animated: true)
          self.tabBarController?.tabBar.isHidden = true
          
          for (index, imageName) in self.imageNames.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(urlString: imageName)
            let button = UIButton()
            button.setTitle("\(index+1)/\(self.imageNames.count)", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 10, weight: .bold)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            let positionX = self.view.frame.width * CGFloat(index) + 20
            //            let positionX = Int(self.scrollview.bounds.width) * index + 20
            imageView.frame = CGRect(x: Int(positionX), y: 0, width: Int(self.view.bounds.width)-40, height: 268)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            self.scrollview.addSubview(imageView)
            imageView.addSubview(button)
            button.snp.makeConstraints {
              $0.trailing.equalToSuperview().offset(-10)
              $0.bottom.equalToSuperview().offset(-10)
              $0.width.equalTo(50)
            }
          }
        }
      case .failure(let error):
        print("error: \(error)")
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    //    collectionview.dataSource = self
    //    collectionview.delegate = self
    //    collectionview.register(TagLabelCell.self, forCellWithReuseIdentifier: TagLabelCell.identifier)
    tableview.register(ShareCell.self, forCellReuseIdentifier: ShareCell.identifier)
    tableview.register(CheckedCell.self, forCellReuseIdentifier: CheckedCell.identifier)
    tableview.delegate = self
    tableview.dataSource = self
    self.navigationController?.navigationBar.topItem?.title = "우리동네 기록"
    //    let toolbar = UIToolbar()
    //    view.addSubview(toolbar)
    //    toolbar.translatesAutoresizingMaskIntoConstraints = false
    //    toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
    //    toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
    //    toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
    //    let toolbarItem1 = UIBarButtonItem(image: UIImage(named: "toolChat"), style: .done, target: self, action: #selector(didTapChat))
    //    let toolbarItem2 = UIBarButtonItem(image: UIImage(named: "toolScrap"), style: .done, target: self, action: nil)
    //    let toolbarItem3 = UIBarButtonItem(image: UIImage(named: "toolShare"), style: .done, target: self, action: nil)
    //    toolbarItem1.tintColor = .gray
    //    toolbarItem2.tintColor = .gray
    //    toolbarItem3.tintColor = .gray
    //    toolbar.setItems([toolbarItem1, toolbarItem2, toolbarItem3], animated: true)
  }
  @objc func didTapChat() {
    let vc = ChattingViewController()
    vc.chatId = self.id
    self.navigationController?.pushViewController(vc, animated: false)
  }
}
extension DetailViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
  func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
    switch state {
    case .willExpand:
      print("WILL EXPAND")
    case .willCollapse:
      print("WILL COLLAPSE")
    case .didExpand:
      print("DID EXPAND")
    case .didCollapse:
      print("DID COLLAPSE")
    }
  }
  func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
    return true
  }
  func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.selectionStyle = .none
    if section == 0 {
      cell.contentView.addSubview(shareButton)
      shareButton.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.centerX.equalToSuperview()
        $0.width.equalTo(146)
        $0.height.equalTo(28)
      }
    } else if section == 1 {
      cell.contentView.addSubview(checkButton)
      checkButton.snp.makeConstraints {
        $0.centerY.equalToSuperview()
        $0.centerX.equalToSuperview()
        $0.width.equalTo(146)
        $0.height.equalTo(28)
      }
    } else if section == 2 {
      cell.contentView.addSubview(userView)
      userView.snp.makeConstraints {
        $0.edges.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return model.filter { !($0 == "") }.count
    } else if section == 1 {
      return 2
    } else {
      return 1
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell1 = tableView.dequeueReusableCell(withIdentifier: ShareCell.identifier) as? ShareCell else { return UITableViewCell() }
    guard let cell2 = tableView.dequeueReusableCell(withIdentifier: CheckedCell.identifier) as? CheckedCell else { return UITableViewCell() }
    cell1.selectionStyle = .none
    cell2.selectionStyle = .none
    if indexPath.section == 0 {
      cell1.setConstraints()
      if model[indexPath.row] != "" {
        cell1.cellButton.setTitle(arraySection0[indexPath.row+1], for: .normal)
        cell1.cellText.text = model[indexPath.row]
      }
      cell1.cellButton.backgroundColor = ColorManager.BackgroundColor
      cell1.cellIndex = indexPath.row
      return cell1
    } else if indexPath.section == 1 {
      cell2.cellSatisfy = self.satisfy
      cell2.setConstraints()
      return cell2
    } else {
      return UITableViewCell()
    }
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 55
    } else if indexPath.section == 0 {
      return 40
    } else {
      return 100
    }
  }
}
//extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return 3
//  }
//  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagLabelCell.identifier, for: indexPath) as? TagLabelCell else { return UICollectionViewCell() }
//    cell.setConstraint()
//    cell.tagsField.text = "#동대문역3번출구"
//    return cell
//  }
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: 100, height: collectionView.bounds.height)
//  }
//}
