//
//  CountryListTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //function for the country image in tabel view cell
    func flagImage(image : UIImage){
        countryFlagImage.image = image
    }
    
    //function for the country name in tabel view cell
    func nameOfTheCountry(text : String){
        countryName.text = text
    }
    
}
