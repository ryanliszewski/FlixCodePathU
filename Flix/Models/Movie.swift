//
//  Movie.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import Foundation

class Movie: NSObject {
  
  var imageURL: URL?
  var title: String?
  var overview: String?
  
  init(movie: [String: Any]){
    title = movie[C.movieDatabase.keys.title] as? String
    overview = movie[C.movieDatabase.keys.overview] as? String
    
    if let imageURLString = movie[C.movieDatabase.keys.imageURL] as? String {
      imageURL = URL(string: imageURLString)
    }
  }

  class func rawMovieDataSerialization(moviesJSONData: Data) -> [Movie]{
    var moviesDataDictionary = [String: Any]()
    var results = [[String: Any]]()
    var movies = [Movie]()
    
    
    do {
      moviesDataDictionary = try (JSONSerialization.jsonObject(with: moviesJSONData, options: []) as? [String: Any])!
      results = (moviesDataDictionary["results"] as? [[String:Any]])!
      for movieDictionary in results {
        let movie = Movie(movie: movieDictionary)
        movies.append(movie)
      }
      return movies
    } catch let parseError {
      print(parseError.localizedDescription)
      return []
    }
  }
}
