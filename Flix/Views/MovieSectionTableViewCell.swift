//
//  MovieSectionTableViewCell.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/17/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class MovieSectionTableViewCell: UITableViewCell {

  @IBOutlet weak var collectionView: UICollectionView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
extension MovieSectionTableViewCell {
  func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate & UICollectionViewDelegateFlowLayout>(_ dataSourceDelegate: D, forRow row: Int) {
    
    collectionView.delegate = dataSourceDelegate
    collectionView.dataSource = dataSourceDelegate
    collectionView.tag = row
    collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
    
    collectionView.reloadData()
    collectionView.collectionViewLayout.invalidateLayout()
  }
}
