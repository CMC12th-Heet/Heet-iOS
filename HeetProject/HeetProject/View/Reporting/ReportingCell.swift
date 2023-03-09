//
//  ReportingCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/05.
//

import UIKit

class ReportingCell: UITableViewCell {
  static let identifier = "ReportingCell"
  //    override var isSelected: Bool {
  //      didSet {
  //        if isSelected {
  //          label.textColor = ColorManager.BackgroundColor
  //        } else {
  //          label.textColor = .gray
  //        }
  //      }
  //    }
  lazy var label: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 16)
    return label
  }()
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  //  override func setSelected(_ selected: Bool, animated: Bool) {
  //    super.setSelected(selected, animated: animated)
  //    if isselected {
  //      label.textColor = ColorManager.BackgroundColor
  //      isselected.toggle()
  //    } else {
  //      label.textColor = .gray
  //      isselected.toggle()
  //    }
  //  }
  override func prepareForReuse() {
    super.prepareForReuse()
    label.textColor = .gray
  }
  func setConstraint() {
    [label]
      .forEach {
        contentView.addSubview($0)
      }
    label.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.centerY.equalToSuperview()
    }
  }
}
