//
//  Images.swift
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
// This is the Model for Hits data

import Foundation

struct Welcome: Codable {
  let hits: [Hits]
}
struct Hits: Codable {
  let webformatURL: String?
  let userImageURL: String?
  let user: String?
  let tags: String?
}
