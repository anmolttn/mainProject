//
//  FavMovieTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 30/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class FavMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieVote: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setMovieImage(image : UIImage){
        moviePoster.image = image
        moviePoster.layer.cornerRadius = (moviePoster.frame.height)/2
        moviePoster.contentMode = .scaleAspectFill
    }
    
}
