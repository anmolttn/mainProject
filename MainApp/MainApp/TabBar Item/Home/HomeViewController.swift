//
//  HomeVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 11/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let api = ApiStruct()
    var trendingMovies  : MoviesData?
    var popularMovies  : MoviesData?
    var bestDramaMovies  : MoviesData?
    var highestRatedMovies : MoviesData?
    var year2020Movies : MoviesData?
    var defaultImage = #imageLiteral(resourceName: "NotFound")
    
    @IBOutlet weak var homeTableView: UITableView!
    var sectionHeader = [nil,"Best Drama","Popular","Highest Rated", "Best Drama Movies Of 2020"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the nib file of table view cell
        let nib = UINib(nibName: "MoviesDataTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "MoviesDataTableViewCell")
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        getTrendingMovies()
        getPopularMovies()
        getbestDramaMovies()
        getHighestRatedMovies()
        getYearmovies()
        homeNavigationBar()
    }
    
    //home navigation bar
    func homeNavigationBar(){
        navigationItem.title = "Home"
        let notification = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(searchMovie))
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchMovie))

        navigationItem.rightBarButtonItems = [search, notification]
    }
    
    @objc func searchMovie(){
        
    }
    
    //function to get the moview data
    func getTrendingMovies(){
        api.getTrendingMovieData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.trendingMovies = response
            }
            self?.homeTableView.reloadData()
        }
    }
    func getPopularMovies(){
        api.getPopularMovieData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.popularMovies = response
            }
            self?.homeTableView.reloadData()
        }
    }
    func getbestDramaMovies(){
        api.getBestDramaMoviesData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.bestDramaMovies = response
            }
            self?.homeTableView.reloadData()
        }
    }
    func getHighestRatedMovies(){
        api.getHighestRatedMoviesdata { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.highestRatedMovies = response
            }
            self?.homeTableView.reloadData()
        }
    }
    func getYearmovies(){
        api.getYear2020MoviesData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.year2020Movies = response
            }
            self?.homeTableView.reloadData()
        }
    }
}

//extension for the table view delagate and data source

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sectionHeader[section] == nil{
            return 0
        }else{
            return 50

        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 300
        }else{
            return 200
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = homeTableView.dequeueReusableCell(withIdentifier: "MoviesDataTableViewCell", for: indexPath) as! MoviesDataTableViewCell
            //fatalError()
            return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           if let cell = cell as? MoviesDataTableViewCell{
               
               cell.moviesCollectionView.tag = indexPath.section
               cell.moviesCollectionView.dataSource = self
               cell.moviesCollectionView.delegate = self
               cell.moviesCollectionView.reloadData()
           }
       }
}
