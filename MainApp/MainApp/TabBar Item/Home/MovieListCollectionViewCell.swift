//
//  MovieListCollectionViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var MovieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setMovieImage(image : UIImage){
        posterImage.image = image
        posterImage.contentMode = .scaleAspectFill
    }

}
