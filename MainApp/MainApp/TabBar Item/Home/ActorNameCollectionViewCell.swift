//
//  ActorNameCollectionViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class ActorNameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        moviePoster.layer.cornerRadius = moviePoster.frame.height/2
        moviePoster.clipsToBounds = true
    }

    func setMovieImage(image : UIImage){
           moviePoster.image = image
       }
}
