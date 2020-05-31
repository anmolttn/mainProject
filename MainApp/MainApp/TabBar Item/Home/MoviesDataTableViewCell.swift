//
//  MoviesDataTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 24/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class MoviesDataTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    let api = ApiStruct()
    
    var section = -1
    static var type = -1
    var Cellview: UIViewController?
    
    static var dataForMovieDetails : MovieResultModel?
    var defaultImage = #imageLiteral(resourceName: "NotFound")
    
    //store the data of movies
    var trendingMovies: [MovieResultModel] = []
    var popularMovies: [MovieResultModel] = []
    var bestDramaMovies: [MovieResultModel] = []
    var highestRatedMovies : [MovieResultModel] = []
    var year2020Movies : [MovieResultModel] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //register nib files
        let nib = UINib(nibName: "MovieListCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        let nib2 = UINib(nibName: "TrendingMoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib2, forCellWithReuseIdentifier: "TrendingMoviesCollectionViewCell")
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    
        //function to get the data from the api
        getTrendingMovies()
        getYearmovies()
        getPopularMovies()
        getbestDramaMovies()
        getHighestRatedMovies()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getTrendingMovies(){
            api.getTrendingMovieData { [weak self] (response) in
                if let response = response as? [MovieResultModel]{
                    self?.trendingMovies = response
                }
                print("trending movies",self?.trendingMovies.count ?? "")
                self?.moviesCollectionView.reloadData()
            }
        }
    func getbestDramaMovies(){
        api.getBestDramaMoviesData { [weak self] (response) in
            if let response = response as? [MovieResultModel]{
                self?.bestDramaMovies = response
            }
            print("best drama movies",self?.bestDramaMovies.count ?? "")
            self?.moviesCollectionView.reloadData()
        }
    }
    func getPopularMovies(){
        api.getPopularMovieData { [weak self] (response) in
            if let response = response as? [MovieResultModel]{
                self?.popularMovies = response
            }
            print("popular movies",self?.popularMovies.count ?? "")
            self?.moviesCollectionView.reloadData()
        }
    }
        func getHighestRatedMovies(){
            api.getHighestRatedMoviesdata { [weak self] (response) in
                if let response = response as? [MovieResultModel]{
                    self?.highestRatedMovies = response
                }
                print("highest rated movies",self?.bestDramaMovies.count ?? "")
                self?.moviesCollectionView.reloadData()
            }
        }
        func getYearmovies(){
            api.getYear2020MoviesData { [weak self] (response) in
                if let response = response as? [MovieResultModel]{
                    self?.year2020Movies = response
                }
                print("2020 year movies",self?.year2020Movies.count ?? "")
                self?.moviesCollectionView.reloadData()
        }
    }
}


//extension for collection view delegate and data sources
extension MoviesDataTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return trendingMovies.count
        case 1:
            return bestDramaMovies.count
        case 2:
            return popularMovies.count
        case 3:
            return highestRatedMovies.count
        case 4:
            return year2020Movies.count
        default:
            return 2
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView.tag == 0{
            print("trending moveis")
            let trendingMovieCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMoviesCollectionViewCell", for: indexPath) as! TrendingMoviesCollectionViewCell
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(trendingMovies[indexPath.row].backdrop_path ?? "\(trendingMovies[indexPath.row].poster_path ?? "")")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            trendingMovieCell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            return trendingMovieCell
        }
        if collectionView.tag == 1{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            print("BestMovieArray")
                cell.MovieName.text = "\(bestDramaMovies[indexPath.row].original_name ?? "\(bestDramaMovies[indexPath.row].original_title ?? "")")"
                cell.movieRating.text = "\(bestDramaMovies[indexPath.row].vote_average ?? 8.5)"
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(bestDramaMovies[indexPath.row].poster_path ?? "\(bestDramaMovies[indexPath.row].backdrop_path ?? "")")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            return cell
        }
        if collectionView.tag == 2{
        print("popular movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            cell.MovieName.text = "\(popularMovies[indexPath.row].original_name ?? "\(popularMovies[indexPath.row].original_title ?? "")")"
            cell.movieRating.text = "\(popularMovies[indexPath.row].vote_average ?? 8.5)"
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(popularMovies[indexPath.row].poster_path ?? "\(popularMovies[indexPath.row].backdrop_path ?? "")")"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            return cell
        }
        if collectionView.tag == 3{
        print("highest rated movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
                cell.MovieName.text = "\(highestRatedMovies[indexPath.row].original_name ?? "\(highestRatedMovies[indexPath.row].original_title ?? "")")"
                cell.movieRating.text = "\(highestRatedMovies[indexPath.row].vote_average ?? 8.5)/10"
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(highestRatedMovies[indexPath.row].poster_path ?? "\(highestRatedMovies[indexPath.row].backdrop_path ?? "")")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                                }
                            }
                        }.resume()
                    }
            return cell
        }
        if collectionView.tag == 4{
        print("2020 year movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
                cell.MovieName.text = "\(year2020Movies[indexPath.row].original_name ?? "\(year2020Movies[indexPath.row].original_title ?? "")")"
                cell.movieRating.text = "\(year2020Movies[indexPath.row].vote_average ?? 8.5)"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(year2020Movies[indexPath.row].poster_path ?? "\(year2020Movies[indexPath.row].backdrop_path ?? "")")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                                }
                            }
                        }.resume()
                    }
            return cell
        }
        else{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            return cell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            let size = collectionView.frame.size
            return CGSize(width: UIScreen.main.bounds.width, height: size.height)
        }
        else{
            return CGSize(width: 200, height: 270)

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        switch collectionView.tag {
        case 0:
            MoviesDataTableViewCell.type = 0
            MoviesDataTableViewCell.dataForMovieDetails = trendingMovies[indexPath.row]
            print("selected Data ", trendingMovies[indexPath.row])
            print(collectionView.tag)
        case 1:
            MoviesDataTableViewCell.type = 1
            MoviesDataTableViewCell.dataForMovieDetails = bestDramaMovies[indexPath.row]
            print(collectionView.tag)
        case 2:
            MoviesDataTableViewCell.type = 2
            MoviesDataTableViewCell.dataForMovieDetails = popularMovies[indexPath.row]
            print(collectionView.tag)
        case 3:
            MoviesDataTableViewCell.type = 3
            MoviesDataTableViewCell.dataForMovieDetails = highestRatedMovies[indexPath.row]
            print(collectionView.tag)
        case 4:
            MoviesDataTableViewCell.type = 4
            MoviesDataTableViewCell.dataForMovieDetails = year2020Movies[indexPath.row]
            print(collectionView.tag)
        default:
            print("Defalut")
        }
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        Cellview?.navigationController!.pushViewController(vc, animated: true)
    }
    
}
