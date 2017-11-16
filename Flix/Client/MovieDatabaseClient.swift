//
//  MovieDatabaseClient.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import Foundation

class MoviedatabaseClient {
  
  class func APICall(endpoint: String?, success: @escaping ([Movie]) -> (), failure: @escaping (Error) -> ()){
    if let endpoint = endpoint {
      let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(C.movieDatabase.API.key)")!
      let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
      let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
      let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
        if let error = error {
          failure(error)
        } else {
          success(Movie.rawMovieDataSerialization(moviesJSONData: data!))
        }
      })
      dataTask.resume()
    }
  }
}
