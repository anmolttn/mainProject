//
//  PracticeViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {

    var movieArray  : MoviesData?
    var defaultImage = #imageLiteral(resourceName: "tvAppLogo")
    
    @IBOutlet weak var practiceTableView: UITableView!
    
    let api = ApiStruct()
    override func viewDidLoad() {
        super.viewDidLoad()

        practiceTableView.delegate = self
        practiceTableView.dataSource = self
        let nib = UINib(nibName: "PracticeTableViewCell", bundle: nil)
        practiceTableView.register(nib, forCellReuseIdentifier: "PracticeTableViewCell")

        getData()
        // Do any additional setup after loading the view.
    }
   
    func getData(){
        api.getTrendingMovieData { [weak self] (response) in
            if let res = response as? MoviesData{
                print("data stored")
                self?.movieArray = res
            }
            self?.practiceTableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func getTrendingMovieData(completionBlock : @escaping () -> ()){
//        _ = URLSessionConfiguration.default
//        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")!)
//        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
//        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
//        _ = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, error) in
//            guard let data = data , let _ = response as? HTTPURLResponse else{
//                return
//            }
//            do{
//                if error == nil{
//                    let decoder = JSONDecoder()
//                    //decoder.keyDecodingStrategy = .useDefaultKeys
//                    let mData = try decoder.decode(MoviesData.self, from: data)
//                    self?.movieArray = mData
//                    print("data fetch")
//                    print("moies data ---->>>",self?.movieArray ?? "error")
//                }
//                DispatchQueue.main.async {
//                    completionBlock()
//                }
//            }catch{
//                print("error",error.localizedDescription)
//            }
//        }.resume()
//    }
}

extension PracticeViewController : UITableViewDelegate, UITableViewDataSource{
        
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.movieArray?.results?.count ?? 20
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = practiceTableView.dequeueReusableCell(withIdentifier: "PracticeTableViewCell", for: indexPath) as! PracticeTableViewCell
            if let data1 = self.movieArray?.results{
                cell.title.text = "title : \(data1[indexPath.row].title ?? "error")"
                cell.releaseDate.text = "release Data : \(data1[indexPath.row].releaseDate ?? "")"
                cell.originalLanguage.text = "Orignal Language : \(data1[indexPath.row].originalLanguage ?? "")"
                cell.movieID.text = "ID : \(data1[indexPath.row].id ?? 1)"
                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].backdropPath ?? "")"){
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let data = data {
                            DispatchQueue.main.async {
                                print("image done")
                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                                cell.movieImage.contentMode = .scaleAspectFit
                            }
                        }
                    }.resume()
                }
            }
            return cell
        }
}
//
////
////  MovieTrendingTableViewCell.swift
////  MainApp
////
////  Created by Anmol Chauhan on 20/05/20.
////  Copyright © 2020 Anmol Chauhan. All rights reserved.
////
//
//import UIKit
//
//class MovieTrendingTableViewCell: UITableViewCell {
//
//    let api = ApiStruct()
//    var movieArray  : MoviesData?
//    var defaultImage = #imageLiteral(resourceName: "loading")
//    var selectedMovieType: Bool = true
//    
//    @IBOutlet weak var collectionViewOutlet: UICollectionView!
//    //@IBOutlet weak var pageControl: UIPageControl!
//    
////    var timer = Timer()
////    var counter = 0
//    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        
//        collectionViewOutlet.delegate = self
//        collectionViewOutlet.dataSource = self
//        
//        let nib1 = UINib(nibName: "MovieListCollectionViewCell", bundle: nil)
//        collectionViewOutlet.register(nib1, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
//        
//        let nib2 = UINib(nibName: "ActorNameCollectionViewCell", bundle: nil)
//        collectionViewOutlet.register(nib2, forCellWithReuseIdentifier: "ActorNameCollectionViewCell")
//         
//        getTrendingMovieData()
//        
//    }
//    
//    
//    func getTrendingMovieData(){
//        api.getTrendingMovieData { [weak self] (response) in
//            if let response = response as? MoviesData{
//                self?.movieArray = response
//            }
//            self?.collectionViewOutlet.reloadData()
//        }
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//}
//
//extension MovieTrendingTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return movieArray?.results?.count ?? 0
//    }
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        if selectedMovieType{
//            let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
//            if let data1 = self.movieArray?.results{
//                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
//                    URLSession.shared.dataTask(with: url) { (data, response, error) in
//                        if let data = data {
//                            print("Trending movies indexpath.section",indexPath.section)
//                            print("Trending movies indexpath.row",indexPath.row)
//                            DispatchQueue.main.async {
//                                cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
//                                cell.posterImage.contentMode = .scaleAspectFill
//                            }
//                        }
//                    }.resume()
//                }
//            }
//            return cell
//        }
//        else{
//            let diffCell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "ActorNameCollectionViewCell", for:indexPath) as! ActorNameCollectionViewCell
//            diffCell.movieTitle.text = "\(movieArray?.results?[indexPath.row].originalTitle ?? "")"
//            diffCell.movieRating.text = "\(movieArray?.results?[indexPath.row].voteAverage ?? 0.0)"
//            if let data1 = self.movieArray?.results{
//                if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
//                    URLSession.shared.dataTask(with: url) { (data, response, error) in
//                        if let data = data {
//                            print("best drama movies indexpath.section",indexPath.section)
//                            print("best drama movies indexpath.row",indexPath.row)
//                            DispatchQueue.main.async {
//                                diffCell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
//                                diffCell.moviePoster.contentMode = .scaleAspectFill
//                            }
//                        }
//                    }.resume()
//                }
//            }
//            return diffCell
//        }
////        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
////        if let data1 = self.movieArray?.results{
////            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
////                URLSession.shared.dataTask(with: url) { (data, response, error) in
////                    if let data = data {
////                        print("Trending movies indexpath.section",indexPath.section)
////                        print("Trending movies indexpath.row",indexPath.row)
////                        DispatchQueue.main.async {
////                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
////                            cell.posterImage.contentMode = .scaleAspectFill
////                        }
////                    }
////                }.resume()
////            }
////        }
////        return cell
//    }
//}
//
//extension MovieTrendingTableViewCell : UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = collectionViewOutlet.frame.size
//        return CGSize(width: size.width, height: size.height)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0
//    }
//}


//home view controller par
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.section == HomeSection.trending{
//           guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "MovieTrendingTableViewCell", for: indexPath) as? MovieTrendingTableViewCell else{
//               fatalError()
//           }
//                  return cell
//              }
//       if indexPath.section == HomeSection.popular{
//                  guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "ActorNameTableViewCell", for: indexPath) as? ActorNameTableViewCell else{
//                      fatalError()
//                  }
//                  return cell
//              }
//       guard let cell = homeTableView.dequeueReusableCell(withIdentifier: "PracticeTableViewCell", for: indexPath) as? PracticeTableViewCell else{
//           fatalError()
//       }
//       return cell
