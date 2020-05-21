//
//  LanguageListTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class LanguageListTableViewCell: UITableViewCell {

    @IBOutlet weak var languageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //function for the language name in tabel view cell
    func nameOfTheLanguage(text : String){
        languageLabel.text = text
    }
    
}
