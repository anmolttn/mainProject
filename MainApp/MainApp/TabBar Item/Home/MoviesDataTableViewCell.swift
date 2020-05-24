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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib = UINib(nibName: "MovieListCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        let nib2 = UINib(nibName: "TrendingMoviesCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib2, forCellWithReuseIdentifier: "TrendingMoviesCollectionViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            trendingMovies?.results?.count ?? 0
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView.tag == 0{
            print("trending moveis")
            let trendingMovieCell =  collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMoviesCollectionViewCell", for: indexPath) as! TrendingMoviesCollectionViewCell
            if let data1 = self.trendingMovies?.results{
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                    print("image")
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            trendingMovieCell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            }
            return trendingMovieCell
        }
        if collectionView.tag == 1{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            print("BestMovieArray")
            if let data1 = self.bestDramaMovies?.results{
                cell.MovieName.text = "\(data1[indexPath.row].originalTitle ?? "\(data1[indexPath.row].title ?? "")")"
                cell.movieRating.text = "\(data1[indexPath.row].voteAverage ?? 8.45)"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            }
            return cell
        }
        if collectionView.tag == 2{
        print("popular movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        if let data1 = self.popularMovies?.results{
            cell.MovieName.text = "\(data1[indexPath.row].originalTitle ?? "\(data1[indexPath.row].title ?? "")")"
            cell.movieRating.text = "\(data1[indexPath.row].voteAverage ?? 8.45)"
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            }
                        }
                    }.resume()
                }
            }
            return cell
        }
        if collectionView.tag == 3{
        print("best kids movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            if let data1 = self.highestRatedMovies?.results{
                cell.MovieName.text = "\(data1[indexPath.row].originalTitle ?? "\(data1[indexPath.row].title ?? "")")"
                cell.movieRating.text = "\(data1[indexPath.row].voteAverage ?? 8.45)"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                                }
                            }
                        }.resume()
                    }
                }
            return cell
        }
        if collectionView.tag == 4{
        print("2020 year movies")
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            if let data1 = self.year2020Movies?.results{
                cell.MovieName.text = "\(data1[indexPath.row].originalTitle ?? "\(data1[indexPath.row].title ?? "")")"
                cell.movieRating.text = "\(data1[indexPath.row].voteAverage ?? 8.45)"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                                }
                            }
                        }.resume()
                    }
                }
            return cell
        }
        else{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
            return cell
        }
    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            let size = collectionView.frame.size
            return CGSize(width: UIScreen.main.bounds.width, height: size.height)
        }
        else{
            return CGSize(width: 200, height: 200)

        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
