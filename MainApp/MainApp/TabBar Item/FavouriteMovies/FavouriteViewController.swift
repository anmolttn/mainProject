//
//  MyCartVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 11/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favMovieTableView: UITableView!
    
    var favListArray : [[String]] = []
    var Counter : Int = 0
    var defaultImage = #imageLiteral(resourceName: "NotFound")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourite Movies"
        favMovieTableView.dataSource = self
        favMovieTableView.delegate = self
            
        let nib = UINib.init(nibName: "FavMovieTableViewCell", bundle: nil)
        favMovieTableView.register(nib, forCellReuseIdentifier: "FavMovieTableViewCell")
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        favListArray = UserDefaults.standard.object(forKey: "favList") as? [[String]] ?? []
        Counter = UserDefaults.standard.object(forKey: "count") as? Int ?? 0
        self.favMovieTableView.reloadData()
    }
        
    //function of table view deleagate and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favListArray.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavMovieTableViewCell", for: indexPath) as! FavMovieTableViewCell
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(favListArray[indexPath.row][0])"){
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                    }
                }
            }.resume()
        }
        cell.movieName.text = favListArray[indexPath.row][1]
        cell.movieDate.text = favListArray[indexPath.row][2]
        cell.movieVote.text = favListArray[indexPath.row][3]
        return cell
    }
           
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

}

