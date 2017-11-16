//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  override func awakeFromNib() {
      super.awakeFromNib()
      posterImageView.clipsToBounds = true
      posterImageView.layer.cornerRadius = 37.5
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      // Configure the view for the selected state
  }

  func bindData(movie: Movie) {
    
    
  }
}
