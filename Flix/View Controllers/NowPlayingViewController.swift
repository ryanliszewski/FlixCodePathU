//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  fileprivate var movies: [Movie] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
  }
}

//MARK: - Helper Functions
extension NowPlayingViewController {
  private func getNowPlayingMovies(){
    MoviedatabaseClient.APICall(endpoint: C.movieDatabase.endpoint.nowPlaying, success: { (movies) in
      self.movies = movies
    }) { (error) in
      print(error.localizedDescription)
    }
  }
}

//MARK: - UITableViewDataSource
extension NowPlayingViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: C.idenifier.cell.movie, for: indexPath) as! MovieTableViewCell
    cell.bindData(movie: movies[indexPath.row])
    return cell
  }
}
