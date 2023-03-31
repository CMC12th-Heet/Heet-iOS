//
//  SceneDelegate.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/10.
//

import UIKit
import SnapKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
//    UserDefaults.standard.set(nil, forKey: "loginToken")
    if (UserDefaults.standard.string(forKey: "loginToken") != nil) {
      window?.rootViewController = CustomTabBarController()
    } else {
      window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
    }
    window?.makeKeyAndVisible()
  }
  func sceneDidDisconnect(_ scene: UIScene) {
  }
  func sceneDidBecomeActive(_ scene: UIScene) {
  }
  func sceneWillResignActive(_ scene: UIScene) {
  }
  func sceneWillEnterForeground(_ scene: UIScene) {
  }
  func sceneDidEnterBackground(_ scene: UIScene) {
  }
}
