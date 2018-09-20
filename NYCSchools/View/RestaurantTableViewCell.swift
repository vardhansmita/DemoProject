//
//  RestaurantTableViewCell.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
 
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var thumbnailImgV: UIImageView!
  @IBOutlet weak var descriptionLbl: UILabel!
  @IBOutlet weak var ratingLbl: UILabel!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
  }
  
}
