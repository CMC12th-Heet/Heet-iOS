//
//  CheckedCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit
import SnapKit

class LocationCell: UITableViewCell {
  static let identifier = "LocationCell"
  var data = [""]
  var isMainLocation: Bool = false
  private let collectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .horizontal
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  func setConstraints() {
    collectionview.delegate = self
    collectionview.dataSource = self
    collectionview.register(LocationGuCell.self, forCellWithReuseIdentifier: LocationGuCell.identifier)
    contentView.addSubview(collectionview)
    collectionview.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.bottom.equalToSuperview()
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
    }
  }
}
extension LocationCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: LocationGuCell.identifier, for: indexPath) as? LocationGuCell else { return UICollectionViewCell() }
    cell.labeltext = data[indexPath.row]
    cell.setConstraint()
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //      let itemSpacing : CGFloat = 20
    //      let myWidth : CGFloat = (collectionView.bounds.width) / CGFloat(data.count)
    return CGSize(width: 70, height: 20)
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if isMainLocation {
      MainLocationViewController.selectedGu = data[indexPath.row]
      MainLocationViewController.myTownLabel.text = "\(MainLocationViewController.selectedCity) \(data[indexPath.row])"
      MainLocationViewController.local2.setTitle(data[indexPath.row], for: .normal)
      MainLocationViewController.local2.isHidden = false
      isMainLocation.toggle()
    } else {
      LocationViewController.temp.append(data[indexPath.row])
      print("datata\(LocationViewController.temp)")
      if LocationViewController.temp.count == 2 {
        LocationViewController.local1.setTitle("\(LocationViewController.temp[1])", for: .normal)
        LocationViewController.local1.isHidden = false
      } else if LocationViewController.temp.count == 3 {
        LocationViewController.local2.setTitle("\(LocationViewController.temp[2])", for: .normal)
        LocationViewController.local2.isHidden = false
      } else if LocationViewController.temp.count == 4 {
        LocationViewController.local3.setTitle("\(LocationViewController.temp[3])", for: .normal)
        LocationViewController.local3.isHidden = false
      }
    }
  }
}
