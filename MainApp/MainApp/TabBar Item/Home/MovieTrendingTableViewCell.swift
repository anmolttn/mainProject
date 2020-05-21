//
//  MovieTrendingTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class MovieTrendingTableViewCell: UITableViewCell {

    let api = ApiStruct()
    var movieArray  : MoviesData?
    var defaultImage = #imageLiteral(resourceName: "loading")
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer = Timer()
    var counter = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        
        let nib1 = UINib(nibName: "MovieListCollectionViewCell", bundle: nil)
        collectionViewOutlet.register(nib1, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        
        pageControl.numberOfPages = 10
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        getData()
        
    }
    
    
    func getData(){
        api.getTrendingMovieData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.movieArray = response
            }
            self?.collectionViewOutlet.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func changeImage(){
        if counter < 10{
            let indexPath = IndexPath.init(item: counter, section: 0)
            self.collectionViewOutlet.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        }
        else{
            let indexPath = IndexPath.init(item: counter, section: 0)
            self.collectionViewOutlet.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
    }
    
}

extension MovieTrendingTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewOutlet.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        if let data1 = self.movieArray?.results{
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(data1[indexPath.row].posterPath ?? "")"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            print("image done")
                            cell.setMovieImage(image: UIImage(data: data) ?? self.defaultImage)
                            cell.posterImage.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
            }
        }
        return cell
    }
}

extension MovieTrendingTableViewCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionViewOutlet.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
