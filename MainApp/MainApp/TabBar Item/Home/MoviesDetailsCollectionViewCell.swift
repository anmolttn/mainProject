//
//  MoviesDetailsCollectionViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 26/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class MoviesDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setMovieImage(image : UIImage){
        moviePoster.image = image
        moviePoster.layer.cornerRadius = (moviePoster.frame.height)/2
        moviePoster.contentMode = .scaleAspectFill
    }

}
