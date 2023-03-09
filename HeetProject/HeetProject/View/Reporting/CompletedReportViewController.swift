//
//  CompletedReportViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//

import UIKit

class CompletedReportViewController: UIViewController {
  private let imageview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "checked"))
    return imageview
  }()
  private let label1: UILabel = {
    let label = UILabel()
    label.text = "신고해주셔서 감사합니다"
    label.font = .systemFont(ofSize: 20, weight: .bold)
    label.textColor = ColorManager.BackgroundColor
    return label
  }()
  private let lineview: UIView = {
    let view = UIView()
    view.backgroundColor = ColorManager.BackgroundColor
    return view
  }()
  private let label2: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 12)
    label.textColor = .gray
    label.text = "HEET 서비스 팀에서 정책에 위반되는지 검토 후 결과를 알려드리겠습니다. 안전한 HEET 서비스가 될 수 있도록 도와주셔서 감사합니다."
    return label
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = .init(title: "완료", style: .done, target: self, action: nil)
    self.navigationItem.rightBarButtonItem?.tintColor = ColorManager.BackgroundColor
    [imageview, label1, view, label2]
      .forEach {
        view.addSubview($0)
      }
    imageview.snp.makeConstraints {
      $0.top.equalToSuperview().offset(291)
      $0.centerX.equalToSuperview()
    }
    label1.snp.makeConstraints {
      $0.top.equalTo(imageview.snp.bottom).offset(19)
      $0.centerX.equalToSuperview()
    }
    lineview.snp.makeConstraints {
      $0.top.equalTo(label1).offset(1)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(194)
    }
    label2.snp.makeConstraints {
      $0.top.equalTo(lineview.snp.bottom).offset(59)
      $0.centerX.equalToSuperview()
    }
  }
}
