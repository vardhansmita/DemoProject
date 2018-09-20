//
//  Restaurant.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//  This is the Model for Restaurant data

import Foundation

struct Restaurant: Codable {
  let name : String?
  let description : String?
  let coverImageUrl : String?
  let avgRating : Float?
  let menus: [Menu]?

  enum  CodingKeys: String, CodingKey {
    case name
    case description
    case coverImageUrl = "cover_img_url"
    case avgRating = "average_rating"
    case menus
  }
}
