//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/15/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit
import PKHUD

class NowPlayingViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let refreshControl = UIRefreshControl()
  
  lazy var alertController: UIAlertController = {
    print("test2")
    let alertController = UIAlertController(title: "Cannot Get Movies", message: "Your internet connection seems to be offline", preferredStyle: .alert)
    let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
      HUD.show(.progress, onView: self.view)
      self.getNowPlayingMovies()
    })
    alertController.addAction(tryAgainAction)
    return alertController
  }()
  
  fileprivate var movies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
        HUD.flash(.success, delay: 0.5)
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("test1")
    HUD.show(.progress, onView: self.view)
    initializeTableView()
    getNowPlayingMovies()
    initializeRefreshControl()
  }
}

//MARK: - Helper Functions
extension NowPlayingViewController {
  private func getNowPlayingMovies(){
    MoviedatabaseClient.APICall(endpoint: C.movieDatabase.endpoint.nowPlaying, success: { (movies) in
      self.movies = movies
    }) { (error) in
      self.present(self.alertController, animated: true)
    }
  }
  
  private func initializeTableView(){
    tableView.dataSource = self
    tableView.rowHeight = 150.0
    tableView.insertSubview(refreshControl, at: 0)
  }
  
  private func initializeRefreshControl(){
    refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)
  }
  
  @objc private func refreshControlAction(refreshControl: UIRefreshControl){
    refreshControl.beginRefreshing()
    getNowPlayingMovies()
    refreshControl.endRefreshing()
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

