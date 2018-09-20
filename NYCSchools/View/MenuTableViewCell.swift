//
//  MenuTableViewCell.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.
//  Copyright © 2018 Smita. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
 
  @IBOutlet weak var menuName: UILabel!
  @IBOutlet weak var itemPrice: UILabel!
  @IBOutlet weak var menuImage: UIImageView!
  @IBOutlet weak var menuDesc: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
