//
//  CustomTabBarController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/25.
//

import UIKit

class CustomTabBarController: UITabBarController {
  let locationImage: UIImageView = {
    let image = UIImageView(image: UIImage(named: "naviLocation"))
    return image
  }()
  let locationLabel: UILabel = {
    let label = UILabel()
    label.text = "서울시 용산구"
    label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
    label.textColor = .white
    return label
  }()
  let naviView: UIView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    view.layer.cornerRadius = 10
    return view
  }()
  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 255, green: 120, blue: 120, alpha: 1)], for: .selected)
    self.tabBar.tintColor = ColorManager.BackgroundColor
    let firstVC = UINavigationController(rootViewController: MainViewController())
    firstVC.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(didTap))
    let search = UIBarButtonItem(image: UIImage(named: "search"), style: .done, target: self, action: #selector(didTapSearch))
    let scrap = UIBarButtonItem(image: UIImage(named: "scrap"), style: .done, target: self, action: #selector(didTapScrap))
    firstVC.navigationBar.topItem?.rightBarButtonItems = [search, scrap]
    firstVC.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(customView: naviView)
    //    var customTabBarItem:UITabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "heart"), selectedImage: UIImage(named: "YOUR_IMAGE_NAME"))
    //    firstVC.tabBarItem = customTabBarItem
    firstVC.tabBarItem.image = UIImage(named: "Location")
    firstVC.tabBarItem.title = "동네 정보"
    firstVC.navigationBar.tintColor = .black
    let secondVC = FollowingViewController()
    secondVC.tabBarItem.title = "팔로잉"
    secondVC.tabBarItem.image = UIImage(named: "followTab")
    let thirdVC = MyPageViewController()
    thirdVC.tabBarItem.title = "마이페이지"
    thirdVC.tabBarItem.image = UIImage(named: "mypageTab")
    self.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
    naviView.addSubview(locationImage)
    naviView.addSubview(locationLabel)
    naviView.snp.makeConstraints {
      $0.width.equalTo(120)
      $0.height.equalTo(30)
    }
    locationImage.snp.makeConstraints {
      $0.left.equalTo(naviView.snp.left).offset(6)
      $0.centerY.equalTo(naviView.snp.centerY)
      $0.width.equalTo(14)
      $0.height.equalTo(17)
    }
    locationLabel.snp.makeConstraints {
      $0.left.equalTo(locationImage.snp.right).offset(5)
      $0.centerY.equalTo(naviView.snp.centerY)
    }
  }
  @objc private func didTap() {
    
  }
  @objc private func didTapSearch() {
    
  }
  @objc private func didTapScrap() {
    
  }
}
