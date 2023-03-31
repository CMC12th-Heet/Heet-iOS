//
//  TagLabelCell.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/08.
//

import UIKit
import WSTagsField

class TagLabelCell: UICollectionViewCell {
  static let identifier = "TagLabelCell"
  let tagsField = WSTagsField()
  func setConstraint() {
    contentView.addSubview(tagsField)
    tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
    tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    tagsField.spaceBetweenLines = 5.0
    tagsField.spaceBetweenTags = 10.0
    tagsField.placeholder = "# 태그하기"
    tagsField.font = .systemFont(ofSize: 12.0)
    tagsField.backgroundColor = .white
    tagsField.tintColor = .gray
    tagsField.textColor = .black
    tagsField.fieldTextColor = .black
    tagsField.delimiter = ","
    tagsField.isDelimiterVisible = true
    tagsField.placeholderColor = .gray
    tagsField.placeholderAlwaysVisible = true
    tagsField.keyboardAppearance = .dark
    tagsField.returnKeyType = .next
    tagsField.acceptTagOption = .space
    tagsField.shouldTokenizeAfterResigningFirstResponder = true
    tagsField.onDidAddTag = { field, tag in
      print("DidAddTag", tag.text)
      field.text = "# \(tag.text)"
      print("field: \(tag.text)")
    }
    tagsField.onDidRemoveTag = { field, tag in
      print("DidRemoveTag", tag.text)
    }
    tagsField.onDidChangeText = { field, text in
      print("DidChangeText")
    }
    tagsField.onDidChangeHeightTo = { _, height in
      print("HeightTo", height)
    }
    tagsField.onValidateTag = { tag, tags in
      return tag.text != "#" && !tags.contains(where: { $0.text.uppercased() == tag.text.uppercased() })
    }
    print("List of Tags Strings:", tagsField.tags.map({ $0.text }))
    tagsField.snp.makeConstraints {
      $0.edges.equalToSuperview().offset(10)
    }
  }
}
