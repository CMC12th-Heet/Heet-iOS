//
//  NetworkError.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/10.
//

import Foundation

enum NetworkResult<T> {
  case success(T)
  case requestError(T)
  case pathError
  case serverError
  case decodeError
  case networkFail
}
