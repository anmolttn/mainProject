//
//  LanguageTableCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class LanguageTableCell: UITableViewCell {

    @IBOutlet weak var languageImageIcon: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageOfLanguageIcon(image : UIImage){
        languageImageIcon.image = image
    }
    
    func labelOfTheLanguage(text : String){
        languageLabel.text = text
    }
    
    func nameOfTheLanguage(text1 : String){
        languageNameLabel.text = text1
    }
}
