//
//  Result.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.
//  Copyright © 2018 Smita. All rights reserved.
//

import Foundation
//Result enum 
enum Result<T, U: Error> {
  case success(payload: T)
  case failure(U?)
}
