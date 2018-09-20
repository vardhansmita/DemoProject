//
//  RestaurantTableViewController.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.//  Copyright © 2018 Smita. All rights reserved.
//  This Controller fetches the list of Restaurant in a particular City and displays its metadata on a TableView

import UIKit
import SVProgressHUD
import SDWebImage

class RestaurantTableViewController: UITableViewController {
  
  fileprivate let cellId = "Cell"
  fileprivate let SegueId = "MenuId"
  fileprivate let networkCall = NetworkRequest()
  var restaurantArray = [Restaurant]()
  var fetchedMenu = [Menu]()
  var popularItems = [PopItems]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    getRestaurantData()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillDisappear(true)
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  //Fetching  Restaurant List from server
  func getRestaurantData(){
    
    networkCall.getRestaurantList { [weak self] result in
      switch result{
      case .success(let restList):
        guard restList.count > 0 else {
          SVProgressHUD.dismiss()
          return
        }
        self?.restaurantArray = restList
        //Moving UI items on main thread
        DispatchQueue.main.async {
          SVProgressHUD.dismiss()
          self?.tableView.reloadData()
        }
      case .failure(let error):
        SVProgressHUD.dismiss()
        Alert.showBasicAlert(title: "Error Connecting", message: error?.getErrorMessage() ?? "Loading failed, Check your Network Connection", vc: self!)
      }
    }
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
    if segue.identifier == SegueId,
      let destinationVC = segue.destination as? MenuTableViewController{
      destinationVC.popItemsArray = popularItems
    }
  }
  override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 135.0
  }
}
extension  RestaurantTableViewController{
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return restaurantArray.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? RestaurantTableViewCell else{
      return UITableViewCell()
    }
    let data = restaurantArray[indexPath.row]
    
    guard let name = data.name,
      let avgR = data.avgRating,
      let desc = data.description,
      let coverImage = data.coverImageUrl else{
        return UITableViewCell()
    }
     //Moving UI items on main thread
    DispatchQueue.main.async {
      cell.nameLbl.text = name
      cell.descriptionLbl.text = desc
      cell.ratingLbl.text = "Rating: \(String(avgR))"
      
      //loading UIimageView
      cell.thumbnailImgV.sd_setImage(with: URL(string:coverImage), placeholderImage: nil, options: [.continueInBackground,.progressiveDownload,.highPriority], completed: nil)
    }
    return cell
  }
}

extension RestaurantTableViewController{
  
  //MARK : TableView Delegate 
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let data = restaurantArray[indexPath.row].menus else{
      return
    }
    fetchedMenu = data.map{$0}
    print(fetchedMenu)
    guard let popItems = fetchedMenu.first?.popularItems else{
      return
    }
    if popItems.count > 0{
      popularItems = popItems.map{$0}
      self.performSegue(withIdentifier: SegueId, sender: self)
      
    }else{
      Alert.showBasicAlert(title: "No menus found", message: "Menus are not provided for this Restaurant", vc: self)
      
    }
    
  }
}


// MARK: - Networking.GetSchoolFailureReason
fileprivate extension NetworkRequest.GetRestFailureReason {
  func getErrorMessage() -> String? {
    switch self {
    case .unAuthorized:
      return "Unauthorized"
    case .notFound:
      return "Could not complete request, please try again."
    }
  }
  
}
