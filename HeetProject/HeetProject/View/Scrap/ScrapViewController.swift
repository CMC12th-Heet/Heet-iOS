//
//  ScrapViewController.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/24.
//

import UIKit
import Alamofire

class ScrapViewController: UIViewController {
  var scrapModel: [LocalPost]?
  let lineview: UIImageView = {
    let imageview = UIImageView(image: UIImage(named: "line1"))
    return imageview
  }()
  private let collectionview: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.minimumLineSpacing = 0
    layout.scrollDirection = .vertical
    layout.sectionInset = .zero
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return cv
  }()
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AF.request(Resource.baseURL + "/post/save",
               method: .get,
               parameters: nil,
               encoding: JSONEncoding.default,
               headers: ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "loginToken") ?? "")"])
    .validate()
    .responseDecodable(of: [LocalPost].self) { response in
      switch response.result {
      case .success(let data): self.scrapModel = data
        print("data \(data)")
        self.collectionview.reloadData()
      case .failure(let error): print("err \(error)")
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    setConstraint()
    collectionview.delegate = self
    collectionview.dataSource = self
    collectionview.register(ScrapCell.self, forCellWithReuseIdentifier: ScrapCell.identifier)
    self.navigationController?.navigationBar.topItem?.title = "스크랩"
    self.tabBarController?.tabBar.isHidden = true
  }
  func setConstraint() {
    view.addSubview(lineview)
    view.addSubview(collectionview)
    lineview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalToSuperview().offset(90)
    }
    collectionview.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.top.equalTo(lineview.snp.bottom).offset(10)
      $0.height.equalTo(1000)
    }
  }
}
extension ScrapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return scrapModel?.count ?? 3
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapCell.identifier, for: indexPath) as? ScrapCell else { return UICollectionViewCell() }
    cell.scrap = self.scrapModel?[indexPath.row]
    cell.label.text = self.scrapModel?[indexPath.row].store?.name
    cell.placeImage.loadImage(urlString: scrapModel?[indexPath.row].file_url ?? "https://heet-storage.s3.ap-northeast-2.amazonaws.com/1679710307826files.jpg")
    cell.setConstraint()
    cell.layer.cornerRadius = 10
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.bounds.width-10) / 2, height: 188)
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 10
  }
}
