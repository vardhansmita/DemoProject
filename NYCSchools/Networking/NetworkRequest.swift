//
//  NetworkRequest.swift
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//  This Class performas the Network call from different API's


import Foundation
import Alamofire

class NetworkRequest{
  
  //Doordash APi to fetch list of restaurants
  let restaurantUrl = "https://api.doordash.com/v1/store_search/?lat=37.7749&lng=-122.4194"
  
  //Pixabay api to fetch list of images
  let imageUrl = "https://pixabay.com/api/?key=10175944-bde2e7682a3714b496fc7b7b7&q=yellow+flowers&image_type=all"
  
  
  //Mark: - GetImages
  
  enum GetImageFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
  }
  
  typealias GetImageResult = Result<Welcome, GetImageFailureReason>
  typealias GetImageCompletion = (_ result: GetImageResult) -> Void
  
  func getImageList(completion: @escaping GetImageCompletion){
    
    guard let endPointUrl = URL(string: imageUrl) else{
      return
    }
    Alamofire.request(endPointUrl)
      .validate()
      .responseJSON { response in
        switch response.result{
        case .success:
          do {
            guard let data = response.data else {
              completion(.failure(nil))
              return
            }
            let fetchedImage = try JSONDecoder().decode(Welcome.self, from: data)
            completion(.success(payload: fetchedImage))
          }catch{
            completion(.failure(nil))
          }
        case .failure(_):
          if let statusCode = response.response?.statusCode,
            let reason = GetImageFailureReason(rawValue: statusCode) {
            completion(.failure(reason))
          }
          completion(.failure(nil))
        }
    }
  }
  

  
  // MARK: - getRestaurantList
  enum GetRestFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
  }
  
  typealias GetRestResult = Result<[Restaurant], GetRestFailureReason>
  typealias GetRestCompletion = (_ result: GetRestResult) -> Void
  
  func getRestaurantList(completion: @escaping GetRestCompletion){
    
    guard let endPointUrl = URL(string: restaurantUrl) else{
      return
    }
    Alamofire.request(endPointUrl)
      .validate()
      .responseJSON { response in
        switch response.result{
        case .success:
          do {
            guard let data = response.data else {
              completion(.failure(nil))
              return
            }
            let restaurant = try JSONDecoder().decode([Restaurant].self, from: data)
            completion(.success(payload: restaurant))
          }catch{
            completion(.failure(nil))
          }
        case .failure(_):
          if let statusCode = response.response?.statusCode,
            let reason = GetRestFailureReason(rawValue: statusCode) {
            completion(.failure(reason))
          }
          completion(.failure(nil))
        }
    }
  }
  
}
