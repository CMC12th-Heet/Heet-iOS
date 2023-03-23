//
//  CustomTabBarController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/25.
//

import UIKit

class CustomTabBarController: UITabBarController {
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.backgroundColor = .systemGray5
  }
  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()
    self.tabBarController?.tabBar.backgroundColor = .systemGray5
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 255, green: 120, blue: 120, alpha: 1)], for: .selected)
    self.tabBar.tintColor = ColorManager.BackgroundColor
    var firstVC: UIViewController = UIViewController()
    if (UserDefaults.standard.string(forKey: "userLocation") == nil) {
      firstVC = MainViewController()
    } else {
      firstVC = MainValidateViewController()
    }
    firstVC = UINavigationController(rootViewController: firstVC)
    let secondVC = UINavigationController(rootViewController: FollowingViewController())
    secondVC.tabBarItem.title = "팔로잉"
    secondVC.tabBarItem.image = UIImage(named: "followTab")
    let thirdVC = UINavigationController(rootViewController: MyPageViewController())
    thirdVC.tabBarItem.title = "마이페이지"
    thirdVC.tabBarItem.image = UIImage(named: "mypageTab")
    thirdVC.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "LoginLogo"), style: .done, target: self, action: nil)
    thirdVC.navigationBar.topItem?.leftBarButtonItem?.tintColor = ColorManager.BackgroundColor
    self.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
//    naviView.addSubview(locationImage)
//    naviView.addSubview(locationLabel)
//    naviView.snp.makeConstraints {
//      $0.width.equalTo(120)
//      $0.height.equalTo(30)
//    }
//    locationImage.snp.makeConstraints {
//      $0.left.equalTo(naviView.snp.left).offset(6)
//      $0.centerY.equalTo(naviView.snp.centerY)
//      $0.width.equalTo(17)
//      $0.height.equalTo(17)
//    }
//    locationLabel.snp.makeConstraints {
//      $0.left.equalTo(locationImage.snp.right).offset(5)
//      $0.centerY.equalTo(naviView.snp.centerY)
//    }
  }
}
