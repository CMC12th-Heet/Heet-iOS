//
//  MyPageViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/24.
//

import UIKit
import Photos
import BSImagePicker
import Alamofire

class MyPageViewController: UIViewController {
  private let profileImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    return imageview
  }()
  private let profileName: UILabel = {
    let label = UILabel()
    label.text = "abcde"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let profileLine: UILabel = {
    let label = UILabel()
    label.text = "소개글을 작성해주세요"
    label.textColor = .systemGray3
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let locationImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "Location"))
    return imageview
  }()
  private let locationLabel: UILabel = {
    let label = UILabel()
    label.text = "중구 약수동"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let markImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "localMark"))
    imageview.isHidden = true
    return imageview
  }()
  private let infoLabel: UILabel = {
    let label = UILabel()
    label.text = "게시글 0  |  팔로잉 0  |  팔로잉 0"
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let followButton: UIButton = {
    let button = UIButton()
    return button
  }()
  private let noPostName: UILabel = {
    let label = UILabel()
    label.text = "아직 게시글이 없어요 ㅠㅠ\n우리동네 숨은 공간을 소개해주세요!"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = .gray
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let noPostImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "ball"))
    //    imageview.isHidden = true
    imageview.layer.shadowOpacity = 0.5
    imageview.layer.shadowColor = UIColor.gray.cgColor
    imageview.layer.shadowOffset = CGSize(width: 0, height: 0)
    imageview.layer.shadowRadius = 10
    imageview.layer.masksToBounds = false
    return imageview
  }()
  private let lineview: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    return view
  }()
  private let collectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
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
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.tabBarController?.tabBar.isHidden = false
    self.tabBarController?.tabBar.backgroundColor = .systemGray6
    print("   dfsdf >>  \(UserDefaults.standard.string(forKey: "loginToken"))")
    NetworkService.shared.requestData(
      url: "/user/my-page",
      method: .get,
      params: nil,
      headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken")!)"], parameters: JSONEncoding(),
      model: MypageModel.self) { response in
        switch response {
        case .success(let t):
          if let t = t as? MypageModel {
            let a = UserDefaults.standard.string(forKey: "loginToken")
            mypageModel = t
            UserDefaults.standard.set(mypageModel?.is_verify, forKey: "isVerify")
            UserDefaults.standard.set(mypageModel?.username, forKey: "username")
            self.locationLabel.text = "\(LocationViewController.city) \(mypageModel?.town ?? "")"
            self.profileName.text = mypageModel?.username
            self.profileLine.text = mypageModel?.status
            self.infoLabel.text = "게시글 \(mypageModel?.post?.count ?? 0) | 팔로잉 2 | 팔로잉 2"
            if ((mypageModel?.is_verify) != nil) {
              self.markImage.isHidden = false
            }
            self.collectionview.reloadData()
          }
        default: break
        }
      }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    collectionview.dataSource = self
    collectionview.delegate = self
    collectionview.register(MypageLocationCell.self, forCellWithReuseIdentifier: MypageLocationCell.identifier)
    let setting = UIBarButtonItem(image: UIImage(named: "setting"), style: .done, target: self, action: #selector(didTapSetting))
    let scrap = UIBarButtonItem(image: UIImage(named: "scrap"), style: .done, target: self, action: #selector(didTapScrap))
    scrap.tintColor = .gray
    self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [setting, scrap]
    self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = .gray
    [profileLine, profileImage, profileName, locationImage, locationLabel, markImage, infoLabel, lineview, noPostImage, noPostName, floatingButton, collectionview]
      .forEach {
        view.addSubview($0)
      }
    noPostImage.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(40)
      $0.trailing.equalToSuperview().offset(-40)
      $0.bottom.equalToSuperview().offset(-200)
      $0.height.equalTo(120)
    }
    noPostName.snp.makeConstraints {
      $0.leading.equalTo(noPostImage.snp.leading).offset(30)
      $0.trailing.equalTo(noPostImage.snp.trailing).offset(-30)
      $0.centerY.equalTo(noPostImage.snp.centerY)
    }
    profileImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(55)
      $0.height.equalTo(55)
    }
    profileName.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(10)
    }
    profileLine.snp.makeConstraints {
      $0.top.equalTo(profileName.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    locationLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileLine.snp.bottom).offset(35)
    }
    locationImage.snp.makeConstraints {
      $0.trailing.equalTo(locationLabel.snp.leading).offset(-10)
      $0.top.equalTo(profileLine.snp.bottom).offset(35)
      $0.width.equalTo(15)
      $0.height.equalTo(20)
    }
    markImage.snp.makeConstraints {
      $0.centerY.equalTo(locationLabel.snp.centerY)
      $0.leading.equalTo(locationLabel.snp.trailing).offset(10)
    }
    infoLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(locationLabel.snp.bottom).offset(20)
    }
    lineview.snp.makeConstraints {
      $0.top.equalTo(infoLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(3)
    }
    floatingButton.snp.makeConstraints {
      $0.trailing.equalTo(view.snp.trailing).offset(-44)
      $0.bottom.equalTo(view.snp.bottom).offset(-105)
      $0.width.equalTo(44)
      $0.height.equalTo(44)
    }
    collectionview.snp.makeConstraints {
      $0.top.equalTo(lineview.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(600)
    }
  }
  @objc private func didTapSetting() {
    self.navigationController?.pushViewController(SettingViewController(), animated: false)
  }
  @objc private func didTapScrap() {
    self.navigationController?.pushViewController(ScrapViewController(), animated: false)
  }
  @objc private func didTapButton() {
    if !UserDefaults.standard.bool(forKey: "isVerify") {
      let vc = MainValidateViewController()
      self.navigationController?.pushViewController(vc, animated: false)
    } else {
      let imagePicker = ImagePickerController()
      imagePicker.settings.selection.max = 10
      presentImagePicker(imagePicker, select: { (asset) in
        if imagePicker.selectedAssets.count == 11 {
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
  }
}
extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mypageModel?.post?.count ?? 2
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MypageLocationCell.identifier, for: indexPath) as? MypageLocationCell else { return UICollectionViewCell() }
    cell.post = mypageModel?.post?[indexPath.row]
    cell.label.text = mypageModel?.post?[indexPath.row].store?.address ?? ""
    cell.setConstraint()
    cell.placeImage.loadImage(urlString: mypageModel?.post?[indexPath.row].file_url?.components(separatedBy: ";").first ?? "https://heet-storage.s3.ap-northeast-2.amazonaws.com/1679710307826files.jpg")
    cell.layer.cornerRadius = 20
    cell.clipsToBounds = true
    cell.layer.cornerRadius = 10
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.bounds.width-10) / 2, height: 188)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}
