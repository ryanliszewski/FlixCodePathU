//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit
import AFNetworking

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
  }

  func bindData(movie: Movie) {
    titleLabel.text = movie.title
    overviewLabel.text = movie.overview
    loadPosterImageView(movie)
  }
  
  private func loadPosterImageView(_ movie: Movie){
    if let smallImageUrl = movie.smallImageURL {
      let smallImageRequest = URLRequest(url: smallImageUrl)
      let largeImageRequest = URLRequest(url: movie.largeImageURL!)
      
      posterImageView.setImageWith(smallImageRequest, placeholderImage: #imageLiteral(resourceName: "launch_image"), success: { (request, response, image) in
        if response != nil {
          self.posterImageView.alpha = 0.0
          self.posterImageView.image = image
          UIView.animate(withDuration: 0.3, animations: {
            self.posterImageView.alpha = 1.0
          }, completion: { (success) in
            self.posterImageView.setImageWith(largeImageRequest, placeholderImage: nil, success: { (request, response, image) in
              if response != nil {
                self.posterImageView.image = image
              }
            }, failure: { (request, response, error) in
              self.setPlaceHolderImage()
            })
          })
        } else {
          self.posterImageView.image = image
        }
      }, failure: { (request, response, error) in
        self.setPlaceHolderImage()
      })
    } else {
      setPlaceHolderImage()
    }
  }
  
  private func setPlaceHolderImage(){
    posterImageView.image = #imageLiteral(resourceName: "launch_image")
  }
}
