//
//  DetailViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//
import UIKit
import SnapKit
import ExpyTableView

class DetailViewController: UIViewController {
  var imageNames: [String] = ["search", "search", "search"]
  let arraySection0: Array<String> = ["", "누구와 함께해요!", "이런 날 방문해요!", "이동 꿀팁", "주문 꿀팁", "기타 꿀팁"]
  let arraySection1: Array<String> = ["ex) 같이 간 사람/가고 싶은 사람","ex) 생일/기념일/기분 꿀꿀한 날","ex) 3번 출구 바로 앞 골목이 지름길!","ex) 시그니처 라떼는 필수입니다.", "ex) 화장실 문고리 잘 흔들려요!"]
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
    button.setImage(UIImage(named: "search"), for: .normal)
    button.layer.cornerRadius = 15
    button.backgroundColor = .systemGray4
    button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    button.tintColor = ColorManager.BackgroundColor
    return button
  }()
  private let shareButton: UIButton = {
    let button = UIButton()
    button.setTitle("꿀팁 정보들 공유하기", for: .normal)
    button.setImage(UIImage(named: "search"), for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.layer.cornerRadius = 15
    button.backgroundColor = .gray
    button.tintColor = .white
    return button
  }()
  private let checkButton: UIButton = {
    let button = UIButton()
    button.setTitle("만족도 체크하기", for: .normal)
    button.setImage(UIImage(named: "search"), for: .normal)
    button.layer.cornerRadius = 15
    button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
    button.backgroundColor = .gray
    button.tintColor = .white
    return button
  }()
  private let titleText: UILabel = {
    let textfield = UILabel()
    textfield.text = "제목"
    textfield.font = .systemFont(ofSize: 17, weight: .bold)
    return textfield
  }()
  private let subTitleText: UILabel = {
    let textfield = UILabel()
    textfield.text = "소제목"
    textfield.font = .systemFont(ofSize: 12, weight: .bold)
    return textfield
  }()
  private let contentText: UILabel = {
    let textview = UILabel()
    textview.text = "내용을 입력하세요"
    textview.numberOfLines = 0
    textview.font = .systemFont(ofSize: 14)
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
    scrollview.frame = UIScreen.main.bounds
    scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageNames.count), height: UIScreen.main.bounds.height)
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
    return view
  }()
  private let userImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
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
    label.text = "팔로워"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  private func setConstraint() {
    self.view.addSubview(totalScrollview)
    totalScrollview.addSubview(totalview)
    [addressButton, scrollview, stackview, tableview, userView, userImage, username, followLabel]
      .forEach {
        totalview.addSubview($0)
      }
    [line1, titleText, line2, subTitleText, line3, contentText, line4]
      .forEach {
        stackview.addArrangedSubview($0)
      }
    userView.snp.makeConstraints {
      $0.top.equalTo(tableview.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.bottom.equalToSuperview().offset(-20)
      $0.height.equalTo(44)
    }
    userImage.snp.makeConstraints {
      $0.centerY.equalTo(userView.snp.centerY)
      $0.leading.equalTo(userView.snp.trailing).offset(10)
      $0.width.equalTo(20)
      $0.height.equalTo(20)
    }
    username.snp.makeConstraints {
      $0.centerY.equalTo(userView.snp.centerY)
      $0.leading.equalTo(userView.snp.trailing).offset(10)
    }
    followLabel.snp.makeConstraints {
      $0.trailing.equalTo(userView.snp.trailing).offset(20)
      $0.centerY.equalTo(userView.snp.centerY)
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
      $0.height.equalTo(1000)
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
      $0.leading.equalTo(totalview.snp.leading).offset(20)
      $0.trailing.equalTo(totalview.snp.trailing).offset(-20)
      $0.height.equalTo(268)
    }
    for (index, imageName) in imageNames.enumerated() {
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image)
      let positionX = self.view.frame.width * CGFloat(index)
      imageView.frame = CGRect(x: positionX, y: 0, width: scrollview.bounds.width + 40, height: scrollview.bounds.height)
      imageView.image = UIImage(named: imageNames[index])
      imageView.contentMode = .scaleAspectFit
      imageView.layer.cornerRadius = 20
      scrollview.addSubview(imageView)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    collectionview.dataSource = self
    collectionview.delegate = self
    collectionview.register(TagLabelCell.self, forCellWithReuseIdentifier: TagLabelCell.identifier)
    tableview.register(ShareCell.self, forCellReuseIdentifier: ShareCell.identifier)
    tableview.register(CheckedCell.self, forCellReuseIdentifier: CheckedCell.identifier)
    self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.title = "우리동네 기록"
    tableview.delegate = self
    tableview.dataSource = self
    setConstraint()
    self.tabBarController?.tabBar.isHidden = true
    let toolbar = UIToolbar()
    view.addSubview(toolbar)
    toolbar.translatesAutoresizingMaskIntoConstraints = false
    toolbar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0).isActive = true
    toolbar.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0).isActive = true
    toolbar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0).isActive = true
    let toolbarItem1 = UIBarButtonItem(image: UIImage(named: "toolChat"), style: .done, target: self, action: #selector(didTapChat))
    let toolbarItem2 = UIBarButtonItem(image: UIImage(named: "toolScrap"), style: .done, target: self, action: nil)
    let toolbarItem3 = UIBarButtonItem(image: UIImage(named: "toolShare"), style: .done, target: self, action: nil)
    toolbar.setItems([toolbarItem1, toolbarItem2, toolbarItem3], animated: true)
    
    let register = UIAction(title: "신고하기", attributes: .keepsMenuPresented, handler: { _ in self.navigationController?.pushViewController(ReportingViewController(), animated: false) })
    let buttonMenu = UIMenu(title: "", children: [register])
    let button = UIBarButtonItem(image: UIImage(named: "more"), style: .done, target: self, action: nil)
    button.menu = buttonMenu
    self.navigationItem.rightBarButtonItem = button
  }
  @objc func didTapChat() {
    self.navigationController?.pushViewController(ChattingViewController(), animated: false)
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
    cell.backgroundColor = .systemGray6 //백그라운드 컬러
    cell.selectionStyle = .none //선택했을 때 회색되는거 없애기
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
      cell.contentView.addSubview(collectionview)
      collectionview.snp.makeConstraints {
        $0.edges.equalToSuperview()
        $0.height.equalTo(50)
      }
    }
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return 6
    } else if section == 1 {
      return 2
    } else {
      return 1
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell1 = tableView.dequeueReusableCell(withIdentifier: ShareCell.identifier) as? ShareCell else { return UITableViewCell() }
    guard let cell2 = tableView.dequeueReusableCell(withIdentifier: CheckedCell.identifier) as? CheckedCell else { return UITableViewCell() }
    if indexPath.section == 0 {
      cell1.setConstraints()
      cell1.cellButton.setTitle(arraySection0[indexPath.row], for: .normal)
      return cell1
    } else if indexPath.section == 1 {
      cell2.setConstraints()
      return cell2
    } else {
      return cell1
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
extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagLabelCell.identifier, for: indexPath) as? TagLabelCell else { return UICollectionViewCell() }
    cell.setConstraint()
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: collectionView.bounds.height)
  }
}

