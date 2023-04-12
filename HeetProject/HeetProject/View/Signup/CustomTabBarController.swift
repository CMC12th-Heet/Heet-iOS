//
//  CustomTabBarController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/25.
//

import UIKit

class CustomTabBarController: UITabBarController {
  override func viewDidLoad() {
    view.backgroundColor = .white
    super.viewDidLoad()
    configureTabBar()
    configureVC()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.backgroundColor = .systemGray6
  }
  private func configureTabBar() {
    self.tabBarController?.tabBar.backgroundColor = .systemGray6
    self.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 255, green: 120, blue: 120, alpha: 1)], for: .selected)
    self.tabBar.tintColor = ColorManager.BackgroundColor
  }
  private func configureVC() {
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
  }
}
