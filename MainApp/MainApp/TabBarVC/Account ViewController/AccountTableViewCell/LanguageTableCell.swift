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
    
    //function for the location logo in tabel view cell
    func imageOfLanguageIcon(image : UIImage){
        languageImageIcon.image = image
    }
    
    //function for the language text in tabel view cell
    func labelOfTheLanguage(text : String){
        languageLabel.text = text
    }
    
    //function for the language name in tabel view cell
    func nameOfTheLanguage(text1 : String){
        languageNameLabel.text = text1
    }
}
