//
//  EditProfileViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class EditProfileViewController: UIViewController {
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  private let logout: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.addTarget(self, action: #selector(didTapLogout), for: .touchDown)
    return button
  }()
  private let exit: UIButton = {
    let button = UIButton()
    button.setTitle("회원탈퇴", for: .normal)
    button.addTarget(self, action: #selector(didTapExit), for: .touchDown)
    return button
  }()
  private let label1: UILabel = {
    let label = UILabel()
    label.text = "이름(필수)"
    return label
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.text = "아이디(필수)"
    return label
  }()
  private let label3: UILabel = {
    let label = UILabel()
    label.text = "소개글 작성"
    return label
  }()
  private let label4: UILabel = {
    let label = UILabel()
    label.text = "중구 약수동"
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let text1: UITextField = {
    let text = UITextField()
    return text
  }()
  private let text2: UITextField = {
    let text = UITextField()
    return text
  }()
  private let text3: UITextView = {
    let text = UITextView()
    return text
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.topItem?.title = "프로필 수정"
  }
  @objc private func didTapLogout() {
    
  }
  @objc private func didTapExit() {
    
  }
}
