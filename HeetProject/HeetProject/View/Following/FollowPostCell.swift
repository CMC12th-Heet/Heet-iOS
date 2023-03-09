//
//  FollowPostCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/07.
//

import UIKit

class FollowPostCell: UITableViewCell {
  static let identifier = "FollowPostCell"
  private let totalview: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 15
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  private let profileImage: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "profile"))
    imageview.contentMode = .scaleAspectFill
    return imageview
  }()
  private let nickname: UILabel = {
    let label = UILabel()
    label.text = "heeoeoife"
    label.textColor = ColorManager.grayColor
    return label
  }()
  private let location: UILabel = {
    let label = UILabel()
    label.text = "카페 704"
    label.textColor = ColorManager.BackgroundColor
    label.font = .systemFont(ofSize: 15, weight: .bold)
    return label
  }()
  let locationImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "location"))
    return imageView
  }()
  let scrapImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "scrap"))
    return imageView
  }()
  //  lazy private var scrollview: UIScrollView = {
  //    let scrollview = UIScrollView()
  //    scrollview.frame = UIScreen.main.bounds
  //    scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(imageNames.count), height: UIScreen.main.bounds.height)
  //    scrollview.delegate = self
  //    scrollview.alwaysBounceVertical = false
  //    scrollview.showsHorizontalScrollIndicator = false
  //    scrollview.showsVerticalScrollIndicator = false
  //    scrollview.isScrollEnabled = true
  //    scrollview.isPagingEnabled = true
  //    scrollview.bounces = false
  //    return scrollview
  //  }()
  override func awakeFromNib() {
    super.awakeFromNib()
    //      let imageView = UIImageView(image: imageName)
    //      let button = UIButton(frame: CGRect(x: 0, y: 0, width: 47, height: 17))
    //      button.setTitle("\(index+1)/\(imageNames.count)", for: .normal)
    //      button.backgroundColor = .white
    //      button.layer.cornerRadius = 10
    //      let positionX = Int(self.scrollview.bounds.width) * index + 20
    //      imageView.frame = CGRect(x: positionX, y: 0, width: Int(view.bounds.width)-40, height: 268)
    //      imageView.contentMode = .scaleAspectFill
    //      imageView.clipsToBounds = true
    //      imageView.layer.cornerRadius = 10
    //      scrollview.addSubview(imageView)
    //      imageView.addSubview(button)
    //      button.snp.makeConstraints {
    //        $0.trailing.equalToSuperview().offset(-10)
    //        $0.bottom.equalToSuperview().offset(-10)
    //      }
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  func setConstraint() {
    contentView.addSubview(totalview)
    totalview.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.height.equalTo(281)
    }
    [profileImage, location, nickname, locationImage]
      .forEach {
        totalview.addSubview($0)
      }
    profileImage.snp.makeConstraints {
      $0.leading.equalTo(totalview.snp.leading).offset(10)
      $0.top.equalTo(totalview.snp.top).offset(10)
      $0.width.equalTo(30)
      $0.height.equalTo(30)
    }
    nickname.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.leading.equalTo(profileImage.snp.trailing)
    }
    locationImage.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalTo(totalview.snp.trailing).offset(-10)
    }
    location.snp.makeConstraints {
      $0.centerY.equalTo(profileImage.snp.centerY)
      $0.trailing.equalTo(locationImage.snp.leading).offset(-10)
    }
  }
}
