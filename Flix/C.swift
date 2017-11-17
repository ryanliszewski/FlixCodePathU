//
//  C.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import Foundation
struct C {
  struct movieDatabase {
    struct API {
      static let key = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
      static let smallImageURL = "https://image.tmdb.org/t/p/w45"
      static let largeImageURL = "https://image.tmdb.org/t/p/original"
    }
    struct keys {
      static let title = "title"
      static let overview = "overview"
      static let imageURL = "poster_path"
    }
    struct endpoint {
      static let nowPlaying = "now_playing"
    }
  }
  
  struct idenifier {
    struct cell {
      static let movie = "MovieCell"
    }
  }
}
