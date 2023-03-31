//
//  MainViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/24.
//

import UIKit
import SnapKit
import BSImagePicker
import Photos

class MainViewController: UIViewController {
  var isRecent = true
  private let totalscroll: UIScrollView = {
    let scrollview = UIScrollView()
    return scrollview
  }()
  private let totalview: UIView = {
    let view = UIView()
    return view
  }()
  private let listImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "list"))
    return imageView
  }()
  private let view1: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 11))
    view.backgroundColor = .black
    return view
  }()
  private let view2: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 11))
    view.backgroundColor = .black
    return view
  }()
  private let recent: UIButton = {
    let label = UIButton()
    label.setTitle("최신순", for: .normal)
    label.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    label.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    label.addTarget(self, action: #selector(didTapRecent), for: .touchDown)
    return label
  }()
  private let best: UIButton = {
    let label = UIButton()
    label.setTitle("베스트순", for: .normal)
    label.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
    label.setTitleColor(.gray, for: .normal)
    label.addTarget(self, action: #selector(didTapBest), for: .touchDown)
    return label
  }()
  private let alertLabel: UILabel = {
    let label = UILabel()
    label.text = "아직 게시글이 없어요 ㅠㅠ"
    return label
  }()
  private let alertLabel2: UILabel = {
    let label = UILabel()
    label.text = "우리 동네 숨은 공간을 소개해주세요!"
    return label
  }()
  private let alertImage: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(LocalCell.self, forCellReuseIdentifier: LocalCell.identifier)
    tableView.isScrollEnabled = false
    tableView.separatorStyle = .none
    return tableView
  }()
  let floatingButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(named: "pencil"), for: .normal)
    button.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    button.backgroundColor = .white
    button.tintColor = ColorManager.BackgroundColor
    button.layer.cornerRadius = 5
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.shadowColor = UIColor.gray.cgColor
    button.layer.shadowOpacity = 1.0
    button.layer.shadowOffset = CGSize.zero
    button.layer.shadowRadius = 6
    return button
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "첫 게시글을 작성하기 전"
    return label
  }()
  private let alert: UILabel = {
    let label = UILabel()
    label.text = "*초기 설정과 다른 위치입니다."
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let button: UIButton = {
    let button = UIButton()
    button.setTitle("인증하기", for: .normal)
    button.layer.cornerRadius = 20
    button.tintColor = ColorManager.BackgroundColor
    return button
  }()
  let leftbutton  = UIButton(type: .custom)
  @objc private func didTapRecent() {
    recent.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    best.setTitleColor(.gray, for: .normal)
    isRecent = true
    NetworkService().getMainPost(url: "/post",
                                 method: .get,
                                 params: [
                                  "isHot": 1,
                                  "city": "\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)"
                                 ],
                                 headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                 model: Post.self) { response in
      switch response.result {
      case .success(let response):
        localPost = response
        print("locaaal \(response)")
        self.tableView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  @objc private func didTapBest() {
    best.setTitleColor(ColorManager.BackgroundColor, for: .normal)
    recent.setTitleColor(.gray, for: .normal)
    isRecent = false
    NetworkService().getMainPost(url: "/post",
                                 method: .get,
                                 params: [
                                  "isNew": 1,
                                  "city": "\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)"
                                 ],
                                 headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                 model: Post.self) { response in
      switch response.result {
      case .success(let response):
        localPost = response
        print("locaaal \(response)")
        self.tableView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }
  @objc private func didTapLocation() {
    self.navigationController?.pushViewController(MainLocationViewController(), animated: true)
  }
  @objc private func didTapButton() {
    if !UserDefaults.standard.bool(forKey: "isVerify") {
      let vc = MainValidateViewController()
      self.navigationController?.pushViewController(vc, animated: false)
    } else {
      let imagePicker = ImagePickerController()
      imagePicker.settings.selection.max = 10
      var imageArr: [UIImage] = []
      presentImagePicker(imagePicker,
                         select: { (asset) in
        if imagePicker.selectedAssets.count == 11 {
          imagePicker.deselect(asset: asset)
          let alert = UIAlertController(title: "", message: "사진은 10장까지 선택 가능합니다.", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "확인", style: .default)
          alert.addAction(okAction)
          imagePicker.present(alert, animated: true)
        }
      },
                         deselect: { (asset) in
      },
                         cancel: { (assets) in
      },
                         finish: { (assets) in
        assets.forEach { phAsset in
          PHImageManager.default().requestImage(for: phAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (image, info) in
            print("image \(image)")
            imageArr.append(image ?? UIImage())
          }
        }
        let vc = WritingViewController()
        vc.imageNames = imageArr
          self.navigationController?.pushViewController(vc, animated: false)
        }
      )
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.navigationBar.isHidden = false
    self.tabBarController?.tabBar.isHidden = false
    leftbutton.setTitle("\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)", for: .normal)
    if isRecent {
      NetworkService().getMainPost(url: "/post",
                                   method: .get,
                                   params: [
                                    "isHot": 1,
                                    "city": "\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)"
                                   ],
                                   headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                   model: Post.self) { response in
        switch response.result {
        case .success(let response):
          localPost = response
          print("locaaal \(response)")
          self.tableView.reloadData()
        case .failure(let error):
          print(error)
        }
      }
    } else {
      NetworkService().getMainPost(url: "/post",
                                   method: .get,
                                   params: [
                                    "isNew": 1,
                                    "city": "\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)"
                                   ],
                                   headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"],
                                   model: Post.self) { response in
        switch response.result {
        case .success(let response):
          localPost = response
          print("locaaal \(response)")
          self.tableView.reloadData()
        case .failure(let error):
          print(error)
        }
      }
    }
  }
  @objc func goScrap() {
    self.navigationController?.pushViewController(ScrapViewController(), animated: false)
  }
  @objc func goSearch() {
    let vc = SearchUserViewController()
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: false)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    print("main viewdid")
    let search = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(goSearch))
    let scrap = UIBarButtonItem(image: UIImage(named: "scrap"), style: .done, target: self, action: #selector(goScrap))
    self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [scrap, search]
    if let image = UIImage(named:"naviLocation") {
      leftbutton.setImage(image, for: .normal)
      leftbutton.setTitle("\(MainLocationViewController.selectedCity) \(MainLocationViewController.selectedGu)", for: .normal)
      leftbutton.setTitleColor(.white, for: .normal)
      leftbutton.backgroundColor = ColorManager.BackgroundColor
    }
    leftbutton.frame = CGRectMake(0.0, 0.0, 120.0, 30.0)
    leftbutton.layer.cornerRadius = 15
    leftbutton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
    leftbutton.addTarget(self, action: #selector(didTapLocation), for: .touchDown)
    let barButton = UIBarButtonItem(customView: leftbutton)
    navigationItem.leftBarButtonItem = barButton
    self.navigationController?.tabBarItem.image = UIImage(named: "Location")
    self.navigationController?.tabBarItem.title = "동네 정보"
    self.navigationController?.navigationBar.tintColor = .black
    //    self.locationLabel.setTitle("\(signTown)", for: .normal)
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .white
    self.view.addSubview(totalscroll)
    self.totalscroll.addSubview(totalview)
    self.totalview.addSubview(tableView)
    self.totalview.addSubview(floatingButton)
    [listImage, view1, view2, recent, best]
      .forEach {
        totalview.addSubview($0)
      }
    totalscroll.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    totalview.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalTo(totalscroll.snp.width)
    }
    tableView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(5000)
    }
    floatingButton.snp.makeConstraints {
      $0.trailing.equalTo(totalscroll.frameLayoutGuide.snp.trailing).offset(-44)
      $0.bottom.equalTo(totalscroll.frameLayoutGuide.snp.bottom).offset(-105)
      $0.width.equalTo(44)
      $0.height.equalTo(44)
    }
    listImage.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(23)
      $0.top.equalTo(totalview.snp.top).offset(10)
    }
    view1.snp.makeConstraints {
      $0.leading.equalTo(listImage.snp.trailing).offset(10)
      $0.centerY.equalTo(listImage.snp.centerY)
      $0.width.equalTo(1)
      $0.height.equalTo(11)
    }
    recent.snp.makeConstraints {
      $0.leading.equalTo(view1.snp.trailing).offset(20)
      $0.centerY.equalTo(listImage.snp.centerY)
    }
    view2.snp.makeConstraints {
      $0.leading.equalTo(recent.snp.trailing).offset(20)
      $0.centerY.equalTo(listImage.snp.centerY)
      $0.width.equalTo(1)
      $0.height.equalTo(11)
    }
    best.snp.makeConstraints {
      $0.leading.equalTo(view2.snp.trailing).offset(20)
      $0.centerY.equalTo(listImage.snp.centerY)
    }
  }
  private func configureLayout() {
  }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return localPost?.posts?.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocalCell.identifier, for: indexPath) as? LocalCell else {
      return UITableViewCell()
    }
    let cellData = localPost?.posts?[indexPath.row]
    cell.setConstraint()
    cell.selectionStyle = .none
    cell.nickname.text = cellData?.user?.username
    cell.localImage.loadImage(urlString: cellData?.urlList?.first ?? "")
    let date = cellData?.created_at ?? "2022-11-12"
    cell.timeLabel.text = String(Array(date)[0..<10])
    cell.title.text = cellData?.title
    cell.desc.text = cellData?.mini_title
    cell.button.setTitle("1/\(cellData?.urlList?.count ?? 0)", for: .normal)
    cell.id = cellData?.post_id ?? 0
    if cellData?.is_local ?? true {
      cell.validImage.isHidden = false
    } else {
      cell.validImage.isHidden = true
    }
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 380
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.id = localPost?.posts?[indexPath.row].post_id ?? 2
    print("idiidid \(localPost?.posts?[indexPath.row].post_id)")
    self.navigationController?.pushViewController(vc, animated: false)
  }
}
