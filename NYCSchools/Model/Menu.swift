//
//  Menu.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//  This is the Model for Menus data

import Foundation

struct Menu: Codable{
  let popularItems: [PopItems]?
  enum  CodingKeys: String, CodingKey {
    case popularItems = "popular_items"
  }
}

struct PopItems: Codable{
  let price: Int?
  let description: String?
  let imageUrl: String?
  let name:String?
 
  enum CodingKeys:String, CodingKey{
    case price
    case description
    case imageUrl = "img_url"
    case name
  }
}
