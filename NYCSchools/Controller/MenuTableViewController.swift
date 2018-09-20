//
//  MenueTableViewController.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//  This Controller shows the detailed Menu Items of the particular Restaurant selected by the user in a TableView

import UIKit
import SDWebImage
import SVProgressHUD

class MenuTableViewController: UITableViewController {
  
  var popItemsArray = [PopItems]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.tintColor = UIColor.white;
    self.navigationItem.title = "Menus"
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
  }
  override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 333.0
  }
}

extension MenuTableViewController{
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return popItemsArray.count 
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MenuTableViewCell else{
      return UITableViewCell()
    }
    let data = popItemsArray[indexPath.row]
    
    guard let name = data.name,
      let price = data.price,
      let desc = data.description,
      let coverImage = data.imageUrl else {
        return UITableViewCell()
    }
    //Moving UI items on main thread
    DispatchQueue.main.async {
      cell.menuName.text = name
      cell.itemPrice.text = "Price: $\(price / 100)"
      cell.menuDesc.text = desc
      
      //loading UIimageView
      cell.menuImage.sd_setImage(with: URL(string:coverImage), placeholderImage: nil, options: [.continueInBackground,.progressiveDownload,.highPriority], completed: nil)
    }
    return cell
  }
  
}
