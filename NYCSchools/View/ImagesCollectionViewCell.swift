//
//  ImagesCollectionViewCell.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
// This is the View For Images List

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
 
  @IBOutlet weak var DisplayImageView: UIImageView!
  @IBOutlet weak var tagLabel: UILabel!
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  
  public func configure() {
   
    //Performing cornerRadius on ImageView
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2;
    self.userImageView.clipsToBounds = true;
  }
  
}
