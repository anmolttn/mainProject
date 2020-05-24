//
//  TrendingMoviesCollectionViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 25/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class TrendingMoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trendingMoviePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMovieImage(image : UIImage){
           trendingMoviePoster.image = image
        trendingMoviePoster.contentMode = .scaleAspectFill
       }
}
