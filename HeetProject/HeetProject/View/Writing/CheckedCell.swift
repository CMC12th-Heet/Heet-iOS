//
//  CheckedCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/04.
//

import UIKit

var selectedFace = 0
class CheckedCell: UITableViewCell {
  static let identifier = "CheckedCell"
  var cellSatisfy: Int?
  var faceImages = ["face1", "face2", "face3", "face4", "face5"]
  var faceLabels = ["화나요.", "별로에요.", "그럭저럭?", "좋았어요!", "재방문100%"]
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
    collectionview.register(FaceCell.self, forCellWithReuseIdentifier: FaceCell.identifier)
    contentView.addSubview(collectionview)
    collectionview.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.bottom.equalToSuperview().offset(-20)
      $0.leading.equalToSuperview().offset(18)
      $0.trailing.equalToSuperview().offset(-18)
      $0.height.equalTo(70)
    }
  }
}
extension CheckedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: FaceCell.identifier, for: indexPath) as? FaceCell else { return UICollectionViewCell() }
    cell.imagename = faceImages[indexPath.row]
    cell.labeltext = faceLabels[indexPath.row]
    if self.cellSatisfy == indexPath.row {
      cell.label.textColor = ColorManager.BackgroundColor
    }
    cell.setConstraint()
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSpacing : CGFloat = 10
    let myWidth : CGFloat = (collectionView.bounds.width) / 5
    return CGSize(width: myWidth, height: collectionview.bounds.height)
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("click \(indexPath)")
    selectedFace = indexPath.row
  }
}
