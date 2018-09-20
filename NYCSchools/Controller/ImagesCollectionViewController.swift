//
//  ImagesCollectionViewController.swift
//  NYCSchools
//
//  Created by Smita on 9/19/18.
//  Copyright © 2018 Smita. All rights reserved.
//  This controller Shows all the images downloaded from the Pixabay servers on a CollectionView

import UIKit
import SDWebImage
import SVProgressHUD

private let reuseIdentifier = "Cell"

class ImagesCollectionViewController: UICollectionViewController {
  
  let networkCall = NetworkRequest()
  var imageArray = [Hits]()
  fileprivate let itemsPerRow: CGFloat = 1
  fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    SVProgressHUD.show()
    getData()
    
  }
  
  func getData(){
    networkCall.getImageList { [weak self] result in
      
      switch result{
      case .success(let images):
        guard images.hits.count > 0 else {
          SVProgressHUD.dismiss()
          return
        }
        self?.imageArray = images.hits
        //Moving UI items on main thread
        DispatchQueue.main.async {
          SVProgressHUD.dismiss()
          self?.collectionView?.reloadData()
        }
      case .failure(let error):
        SVProgressHUD.dismiss()
        Alert.showBasicAlert(title: "Error Connecting", message: error?.getErrorMessage() ?? "Loading failed, Check your Network Connection", vc: self!)
      }
    }
  }
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imageArray.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImagesCollectionViewCell else{
      return UICollectionViewCell()
    }
    cell.configure()
    
    let data = imageArray[indexPath.row]
    guard let coverImage = data.webformatURL,
      let userName = data.user,
      let tags = data.tags,
      let userImage = data.userImageURL
      else{
        return UICollectionViewCell()
    }
    
    
    //loading UIimageView
    cell.tagLabel.text = "Tags: \(tags)"
    cell.userNameLabel.text = "User: \(userName)"
    cell.userImageView.sd_setImage(with: URL(string:userImage), placeholderImage: UIImage(named: "user"), options: [.continueInBackground,.progressiveDownload,.highPriority], completed: nil)
    cell.DisplayImageView.sd_setImage(with: URL(string:coverImage), placeholderImage: UIImage(named: "Placeholder"), options: [.continueInBackground,.progressiveDownload,.highPriority], completed: nil)
    
    return cell
  }
  
}
extension ImagesCollectionViewController : UICollectionViewDelegateFlowLayout {
  //1
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    //2
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  //3
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  // 4
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

// MARK: - Networking.GetImageFailureReason
fileprivate extension NetworkRequest.GetImageFailureReason {
  func getErrorMessage() -> String? {
    switch self {
    case .unAuthorized:
      return "Unauthorized"
    case .notFound:
      return "Could not complete request, please try again."
    }
  }
}
