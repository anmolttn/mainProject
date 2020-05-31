//
//  MovieDetailsViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 25/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDetails: UILabel!
    @IBOutlet weak var movierating: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var favMovieButton: UIButton!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    //store the data of movies
    var arrayOfMovieResult: [MovieResultModel] = []
    var views : UIViewController?
    var result: MovieResultModel?
    var indexOfMovie: Int?
    
    //store the data of favourite movie
    var newFav : [String] = []
    var favMovieArray: [[String]] = []
    var counterForFav : Int = 0
    
    var defaultImage = #imageLiteral(resourceName: "NotFound")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        views = self
        
        getData()
        
        let nib = UINib(nibName: "MoviesDetailsCollectionViewCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "MoviesDetailsCollectionViewCell")
        setSelectedMovieDetails()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //use user default for teh favourite movies
        if UserDefaults.standard.object(forKey: "count") != nil{
            counterForFav = UserDefaults.standard.object(forKey: "count") as! Int
        }
        if UserDefaults.standard.object(forKey: "favList") != nil{
            favMovieArray = UserDefaults.standard.object(forKey: "favList") as! [[String]]
        }
    }
    
    func setMovieImage(image : UIImage){
        moviePoster.image = image
        moviePoster.contentMode = .scaleAspectFill
    }
    
    //function to set the data in view
    func setSelectedMovieDetails(){
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(MoviesDataTableViewCell.dataForMovieDetails?.backdrop_path ?? "\(MoviesDataTableViewCell.dataForMovieDetails?.poster_path ?? "")")"){
            print("data in details ",MoviesDataTableViewCell.dataForMovieDetails?.poster_path ?? "")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                    }
                }
            }.resume()
        }
        movieReleaseDate.text = "\((MoviesDataTableViewCell.dataForMovieDetails?.release_date)?.prefix(4) ?? "\((MoviesDataTableViewCell.dataForMovieDetails?.first_air_date)?.prefix(4) ?? "")")"
        movieName.text = "\(MoviesDataTableViewCell.dataForMovieDetails?.original_name ?? "\(MoviesDataTableViewCell.dataForMovieDetails?.title ?? "No data")")"
        movierating.text = "\(MoviesDataTableViewCell.dataForMovieDetails?.vote_average ?? 8.5)/10"
        movieDetails.text = MoviesDataTableViewCell.dataForMovieDetails?.overview
        let languageOfMovie = MoviesDataTableViewCell.dataForMovieDetails?.original_language
        if languageOfMovie == "hi"{
            movieLanguage.text = "Hindi"
        }
        else{
            movieLanguage.text = "English"
        }
        
        //enter the selelcted movie in array
        newFav.append(MoviesDataTableViewCell.dataForMovieDetails?.poster_path ?? MoviesDataTableViewCell.dataForMovieDetails?.backdrop_path ?? "")
        newFav.append(MoviesDataTableViewCell.dataForMovieDetails?.original_title ?? MoviesDataTableViewCell.dataForMovieDetails?.original_name ?? "")
        newFav.append(MoviesDataTableViewCell.dataForMovieDetails?.release_date ?? MoviesDataTableViewCell.dataForMovieDetails?.first_air_date ?? "")
        newFav.append("\(MoviesDataTableViewCell.dataForMovieDetails?.vote_average ?? 8.5)/10")
        
        if favMovieArray.contains(newFav){
            favMovieButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            favMovieButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        favMovieButton.contentMode = .scaleAspectFit

    }
    
    //function to get the data in the below collection view cell
    func getData() {
     URLCache.shared.removeAllCachedResponses()
     URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
     let urlForBelowCells : String
    if MoviesDataTableViewCell.type == 0
    {
         urlForBelowCells = "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
     
     else if MoviesDataTableViewCell.type == 1
    {
         urlForBelowCells = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
     
     else if MoviesDataTableViewCell.type == 2
    {
         urlForBelowCells = "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
     
     else if MoviesDataTableViewCell.type == 3
    {
         urlForBelowCells = "http://api.themoviedb.org/3/discover/movie?certification_country=US&certification=R&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
     else if MoviesDataTableViewCell.type == 4
    {
         urlForBelowCells = "https://api.themoviedb.org/3/discover/movie?primary_release_year=2020&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
     else
    {
         urlForBelowCells = "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66"
     }
        
    _ = URLSessionConfiguration.default
    let request = URLRequest(url: URL(string: urlForBelowCells)!)
    _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
        guard let data = data , let _ = response as? HTTPURLResponse else{
            return
        }
        do{
            if error == nil{
                let decoder = JSONDecoder()
                let jSonResult = try decoder.decode(MoviesData.self, from: data)
                if let results = jSonResult.results{
                    for item in results{
                        self.arrayOfMovieResult.append(item)
                    }
                }
            }
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        }catch{
            print("error",error.localizedDescription)
        }
        }.resume()
    }
    
    //button that direct the view to root view controller
    @IBAction func backButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        _ = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        
        if favMovieArray.contains(newFav){
            favMovieArray.remove(at: favMovieArray.firstIndex(of: newFav) ?? 0)
            counterForFav = counterForFav - 1
        }
        else{
            counterForFav+=1
            favMovieArray.append(newFav)
        }
        
        UserDefaults.standard.set(counterForFav, forKey: "count")
        UserDefaults.standard.set(favMovieArray, forKey: "favList")
        
        if favMovieArray.contains(newFav){
            favMovieButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            favMovieButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        favMovieButton.contentMode = .scaleAspectFit
    }
    
}

//extension of collection view delegate and datasource
extension MovieDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfMovieResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "MoviesDetailsCollectionViewCell", for: indexPath) as! MoviesDetailsCollectionViewCell
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(arrayOfMovieResult[indexPath.row].poster_path ?? "\(arrayOfMovieResult[indexPath.row].backdrop_path ?? "")")"){
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MoviesDataTableViewCell.dataForMovieDetails = arrayOfMovieResult[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController")
        //views?.navigationController?.popViewController(animated: true)
        views?.navigationController!.pushViewController(vc, animated: true)

    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height:200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
