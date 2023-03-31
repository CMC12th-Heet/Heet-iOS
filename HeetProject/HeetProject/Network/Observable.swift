//
//  Observable.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/09.
//

import Foundation

class Observable<T> {
  private var listener: ((T) -> Void)?
  var value: T {
    didSet {
      self.listener?(value)
    }
  }
  init(_ value: T) {
    self.value = value
  }
  func bind(_ closure: @escaping (T) -> Void) {
    closure(value)
    self.listener = closure
  }
}
