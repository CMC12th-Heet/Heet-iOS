//
//  SceneDelegate.swift
//  HeetProject
//
//  Created by 고명주 on 2023/02/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = ViewController()
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
