//
//  ActorNameTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class ActorNameTableViewCell: UITableViewCell {

    
    let api = ApiStruct()
    var movieArray  : MoviesData?
    var defaultImage = #imageLiteral(resourceName: "loading")
    
    @IBOutlet weak var actorCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nib2 = UINib(nibName: "ActorNameCollectionViewCell", bundle: nil)
        actorCollectionView.register(nib2, forCellWithReuseIdentifier: "ActorNameCollectionViewCell")
        
        actorCollectionView.delegate = self
        actorCollectionView.dataSource = self
        
        getData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getData(){
        api.getPopularMovieData{ [weak self] (response) in
            if let response = response as? MoviesData{
                self?.movieArray = response
            }
            self?.actorCollectionView.reloadData()
           }
       }
    
}


extension ActorNameTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let diffCell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: "ActorNameCollectionViewCell", for:indexPath) as! ActorNameCollectionViewCell
        if let data1 = self.movieArray?.results{
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].backdropPath ?? "")"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            print("image done")
                            diffCell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            diffCell.moviePoster.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
            }
        }
        return diffCell
    }
    
}
