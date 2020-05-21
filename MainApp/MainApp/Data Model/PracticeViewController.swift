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
