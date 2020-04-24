//
//  CountryTableCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class CountryTableCell: UITableViewCell {

    @IBOutlet weak var countryImageIcon: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
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
    
    func countryLogo(image : UIImage){
        countryImageIcon.image = image
    }
    
    func countryText(text : String){
        countryLabel.text = text
    }
    
    func countryFlag(image1 : UIImage){
        countryFlagImage.image = image1
    }
    
    func nameOfTheCountry(text1 : String){
        countryName.text = text1
    }
}
