//
//  NetworkService.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/09.
//

import Foundation
import Alamofire

var emailCode = ""
var isDuplicated: Bool? = false
var userId = ""
var token = ""
var mypageModel: MypageModel?
var storeList: [StoreModel]?
var storeId: StoreIdModel?
var stId: Int?
var localPost: Post?

class NetworkService {
  static let shared = NetworkService()
  private init() {}
  private func judgeStatus<T: Decodable>(by statusCode: Int, _ data: Data, model: T.Type) -> NetworkResult<Any> {
    switch statusCode {
    case 201: return isValidData(data: data, model: model)
    case 400: return .pathError
    case 500: return .serverError
    default: return .networkFail
    }
  }
  private func isValidData<T: Decodable>(data: Data, model: T.Type) -> NetworkResult<Any> {
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(T.self, from: data) else {
      return .decodeError
    }
    return .success(decodedData)
  }
  func deleteUser(completion: @escaping (NetworkResult<Any>) -> Void) {
    AF.request(Resource.baseURL+"/user",
               method: .delete,
               encoding: JSONEncoding.default,
               headers: Resource.header)
    .responseData { dataResponse in
      switch dataResponse.result {
      case.success:
        guard let statusCode = dataResponse.response?.statusCode else {return}
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value, model: LoginModel.self)
        completion(networkResult)
      case.failure: completion(.pathError)
      }
    }
  }
  func requestData<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    parameters: ParameterEncoding,
    model: T.Type,
    completion: @escaping (NetworkResult<Any>) -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: parameters,
               headers: headers)
    .responseData { dataResponse in
      switch dataResponse.result {
      case.success:
        guard let statusCode = dataResponse.response?.statusCode else {return}
        guard let value = dataResponse.value else { return }
        let networkResult = self.judgeStatus(by: statusCode, value, model: model)
        completion(networkResult)
      case.failure: completion(.pathError)
      }
    }
  }
}
