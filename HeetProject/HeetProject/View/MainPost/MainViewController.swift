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
    return view
  }()
  private let view2: UIView = {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 11))
    return view
  }()
  private let recent: UILabel = {
    let label = UILabel()
    label.text = "최신순"
    label.textColor = .gray
    return label
  }()
  private let best: UILabel = {
    let label = UILabel()
    label.text = "베스트순"
    label.textColor = .gray
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
    let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    tableView.register(LocalCell.self, forCellReuseIdentifier: LocalCell.identifier)
    tableView.isScrollEnabled = false
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
  @objc private func didTapButton() {
    let imagePicker = ImagePickerController()
    imagePicker.settings.selection.max = 10
    presentImagePicker(imagePicker, select: { (asset) in
      if imagePicker.selectedAssets.count == 3 {
        imagePicker.deselect(asset: asset)
        let alert = UIAlertController(title: "", message: "사진은 10장까지 선택 가능합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        imagePicker.present(alert, animated: true)
      }
    }, deselect: { (asset) in
    }, cancel: { (assets) in
    }, finish: { (assets) in
      var imageArr: [UIImage] = []
      assets.forEach {
        PHImageManager.default().requestImage(for: $0, targetSize: .zero, contentMode: .aspectFill, options: .none) { (image, info) in
          imageArr.append(image ?? UIImage())
        }
      }
      let vc = WritingViewController()
      vc.imageNames = imageArr
      self.navigationController?.pushViewController(vc, animated: false)
    })
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    self.navigationController?.navigationBar.isHidden = true
    self.tabBarController?.tabBar.isHidden = false
  }
  override func viewDidLoad() {
    super.viewDidLoad()
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
      $0.top.equalTo(listImage.snp.bottom)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1500)
    }
    floatingButton.snp.makeConstraints {
      $0.trailing.equalTo(totalscroll.frameLayoutGuide.snp.trailing).offset(-44)
      $0.bottom.equalTo(totalscroll.frameLayoutGuide.snp.bottom).offset(-105)
      $0.width.equalTo(44)
      $0.height.equalTo(44)
    }
    listImage.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(23)
      $0.top.equalTo(totalview.snp.top).offset(100)
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
    return 10
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: LocalCell.identifier, for: indexPath) as? LocalCell else {
      return UITableViewCell()
    }
    cell.setConstraint()
    cell.selectionStyle = .none
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 360
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    self.navigationController?.pushViewController(vc, animated: false)
  }
}
