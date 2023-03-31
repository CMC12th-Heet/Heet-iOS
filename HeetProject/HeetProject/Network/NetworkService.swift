//
//  NetworkService.swift
//  HeetProject
//
//  Created by 고명주 on 2023/03/09.
//

import Foundation
import Alamofire

var emailCode = ""
var isDuplicated = false
var userId = ""
var token = ""
var mypageModel: MypageModel?
var storeList: [StoreModel]?
var storeId: StoreIdModel?
var stId: Int?
var localPost: Post?

class NetworkService {
  static let shared = NetworkService()
  private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
    switch statusCode {
    case 201: return isValidData(data: data)
    case 400: return .pathError
    case 500: return .serverError
    default: return .networkFail
    }
  }
  private func isValidData(data: Data) -> NetworkResult<Any> {
    let decoder = JSONDecoder()
    guard let decodedData = try? decoder.decode(LoginModel.self, from: data) else {
      return .decodeError
    }
    return .success(decodedData.token)
  }
  func postData(completion: @escaping (NetworkResult<Any>) -> Void) {
    let dataRequest = AF.request(Resource.baseURL,
                                 method: .post,
                                 encoding: JSONEncoding.default,
                                 headers: Resource.header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case.success:
        guard let statusCode = dataResponse.response?.statusCode else {return}
        guard let value = dataResponse.value else {return}
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case.failure: completion(.pathError)
      }
    }
  }
  func varifyEmail<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
//    encoding: ParameterEncoding,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: JSONEncoding(),
               headers: headers)
    .validate()
    .responseDecodable(of: SignupModel.self) { response in
      switch response.result {
      case .success(let response):
        emailCode = String(response.code)
        print("code \(emailCode)")
        completion()
      case .failure(let error):
        print(error.errorDescription)
      }
    }
  }
  func varifyId<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: JSONEncoding(),
               headers: headers)
    .validate()
    .responseDecodable(of: CheckingIdModel.self) { response in
      switch response.result {
      case .success(let response):
        //        completion(response.value, nil)
        isDuplicated = response.isDuplicated
        completion()
      case .failure(let error):
        //        completion(nil, error)
        print(error.errorDescription)
      }
    }
  }
  func registerUser(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: JSONEncoding(),
               headers: headers)
    .validate(statusCode: 200..<300)
    .responseDecodable(of: SignupUser.self) { response in
      switch response.result {
      case .success(let response):
        print("oooo regist \(response.username)")
        completion()
      case .failure(let error):
        print(error.errorDescription)
      }
    }
    .response { response in
      switch response.result {
      case .success(let response):
        completion()
        print(response)
      case .failure(let error):
        print(error.errorDescription)
      }
    }
  }
  func login<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: JSONEncoding(),
               headers: headers)
    .validate()
    .responseDecodable(of: LoginModel.self) { response in
      switch response.result {
      case .success(let response):
        MainLocationViewController.selectedCity = String(Array(response.town)[0...1])
        MainLocationViewController.selectedGu = String(Array(response.town)[3...])
        MainLocationViewController.myTownLabel.text = response.town
        print("meme \(response.message)")
        UserDefaults.standard.set(response.token, forKey: "loginToken")
        completion()
      case .failure(let error):
        print(error.errorDescription)
      }
    }
  }
  func getMypage<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: JSONEncoding(),
               headers: headers)
    .validate()
    .responseDecodable(of: MypageModel.self) { response in
      switch response.result {
      case .success(let response):
        //        completion(response.value, nil)
        //        UserDefaults.standard.set(response.token, forKey: "loginToken")
        let a = UserDefaults.standard.string(forKey: "loginToken")
        print("ototototooto \(a)")
        print(response)
        mypageModel = response
        completion()
      case .failure(let error):
        //        completion(nil, error)
        print(error.errorDescription)
      }
    }
  }
  func getStore<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
    completion: @escaping () -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: URLEncoding.queryString,
               headers: headers)
    .validate()
    .responseDecodable(of: [StoreModel].self) { response in
      switch response.result {
      case .success(let response):
        print(">>>> resres \(response)")
        storeList = response
        completion()
      case .failure(let error):
        //        completion(nil, error)
        print(error.errorDescription)
      }
    }
  }
  func getMainPost<T: Decodable>(
    url: String,
    method: HTTPMethod,
    params: Parameters?,
    headers: HTTPHeaders?,
    model: T.Type,
    completion: @escaping (DataResponse<T, AFError>) -> Void
  )
  {
    AF.request(Resource.baseURL + url,
               method: method,
               parameters: params,
               encoding: URLEncoding.queryString,
               headers: headers)
    .validate()
    .responseDecodable(of: model.self) { response in
      completion(response)
    }
  }
  func deleteUser(completion: @escaping (NetworkResult<Any>) -> Void) {
    let dataRequest = AF.request(Resource.baseURL+"/user",
                                 method: .delete,
                                 encoding: JSONEncoding.default,
                                 headers: Resource.header)
    dataRequest.responseData { dataResponse in
      switch dataResponse.result {
      case.success:
        guard let statusCode = dataResponse.response?.statusCode else {return}
        guard let value = dataResponse.value else {return}
        let networkResult = self.judgeStatus(by: statusCode, value)
        completion(networkResult)
      case.failure: completion(.pathError)
      }
    }
  }
}
