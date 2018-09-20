//
//  Alert.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.
//  Copyright © 2018 Smita. All rights reserved.
//


import Foundation
import UIKit

//Helper class for Alert Controller 
class Alert {
  class func showBasicAlert(title:String , message: String, vc: UIViewController){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    vc.present(alert,animated: true,completion: nil)
  }
}
