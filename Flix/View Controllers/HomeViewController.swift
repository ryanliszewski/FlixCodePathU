//
//  HomeViewController.swift
//  Flix
//
//  Created by Ryan Liszewski on 11/17/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  var nowPlayingMovies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  var upcomingMovies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  var popularMovies: [Movie] = [] {
    didSet {
      DispatchQueue.main.async {
        print(self.popularMovies.elementsEqual(self.nowPlayingMovies))
        self.tableView.reloadData()
      }
    }
    
    
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    getMovies()
    tableView.dataSource = self
    tableView.delegate = self
    }
}

//MARK: - Helper methods
extension HomeViewController {
  
  private func getMovies(){
    MoviedatabaseClient.movieAPICall(endpoint: C.movieDatabase.endpoint.nowPlaying, success: { (nowPlayingMovies) in
      self.nowPlayingMovies = nowPlayingMovies
      print(self.nowPlayingMovies)
    }) { (error) in
    }
    
    MoviedatabaseClient.movieAPICall(endpoint: C.movieDatabase.endpoint.popular, success: { (popularMovies) in
      self.popularMovies = popularMovies
    }) { (error) in
      
    }
    
    MoviedatabaseClient.movieAPICall(endpoint: C.movieDatabase.endpoint.upcoming, success: { (upcomingMovies) in
      self.upcomingMovies = upcomingMovies
    }) { (error) in
    }
  }
  
}

extension HomeViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: C.idenifier.cell.movieSectionTableView, for: indexPath) as! MovieSectionTableViewCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}

extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
    
    let homeTextLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 100, height: 30))
    homeTextLabel.adjustsFontSizeToFitWidth = true
    homeTextLabel.font = UIFont (name: "HelveticaNeue", size: 20)
    
    if(section == 0){
      homeTextLabel.text = "Now Playing"
    } else if section == 1 {
      homeTextLabel.text = "Popular"
    } else if section == 2 {
      homeTextLabel.text = "Upcoming"
    }
    
    headerView.addSubview(homeTextLabel)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
    guard let movieSectionTableViewCell = cell as? MovieSectionTableViewCell
      else {
        return
    }
    movieSectionTableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C.idenifier.cell.movieCollectionView, for: indexPath) as! MovieCollectionViewCell
    
    if indexPath.section == 0 && !nowPlayingMovies.isEmpty{
      let movie = nowPlayingMovies[indexPath.row]
      cell.bindData(movie: movie)
    } else if indexPath.section == 1 && !popularMovies.isEmpty{
      let movie = popularMovies[indexPath.row]
      cell.bindData(movie: movie)
    } else if !upcomingMovies.isEmpty {
      let movie = upcomingMovies[indexPath.row]
      cell.bindData(movie: movie)
    }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return 10 
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let rowHeight = collectionView.frame.height
    let size = CGSize(width: rowHeight, height: rowHeight)
    return size
  }
}
