//
//  MyPageViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/24.
//

import UIKit

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
    let imageview = UIImageView(image: UIImage(named: "location"))
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
    let imageview = UIImageView(image: UIImage(named: "location"))
    return imageview
  }()
  private let infoLabel: UILabel = {
    let label = UILabel()
    label.text = "게시글 0  |  팔로잉 0  |  팔로잉 0"
    label.textColor = ColorManager.grayColor
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  private let lineview: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray3
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
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    collectionview.dataSource = self
    collectionview.delegate = self
    collectionview.register(MypageLocationCell.self, forCellWithReuseIdentifier: MypageLocationCell.identifier)
    let setting = UIBarButtonItem(image: UIImage(named: "setting"), style: .done, target: self, action: #selector(didTapSetting))
    let scrap = UIBarButtonItem(image: UIImage(named: "scrap"), style: .done, target: MyPageViewController.self, action: #selector(didTapScrap))
    self.navigationController?.navigationBar.topItem?.rightBarButtonItems = [setting, scrap]
    [profileLine, profileImage, profileName, locationImage, locationLabel, markImage, infoLabel, lineview, collectionview]
      .forEach {
        view.addSubview($0)
      }
    profileImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(100)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(55)
      $0.height.equalTo(55)
    }
    profileName.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(20)
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
      $0.trailing.equalTo(locationLabel.snp.leading).offset(10)
      $0.top.equalTo(profileLine.snp.bottom).offset(35)
    }
    markImage.snp.makeConstraints {
      $0.centerY.equalTo(locationLabel.snp.centerY)
      $0.leading.equalTo(locationLabel.snp.trailing).offset(10)
    }
    infoLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(locationLabel.snp.bottom).offset(25)
    }
    lineview.snp.makeConstraints {
      $0.top.equalTo(infoLabel.snp.bottom).offset(30)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.height.equalTo(3)
    }
    collectionview.snp.makeConstraints {
      $0.top.equalTo(lineview.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(600)
    }
  }
  @objc private func didTapSetting() {
    print("ppppp")
    self.navigationController?.pushViewController(SettingViewController(), animated: false)
  }
  @objc private func didTapScrap() {
    
  }
}
extension MyPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MypageLocationCell.identifier, for: indexPath) as? MypageLocationCell else { return UICollectionViewCell() }
    cell.setConstraint()
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
