//
//  AccountTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 11/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    @IBOutlet weak var accountTableViewImage: UIImageView!
    @IBOutlet weak var accountTableViewText: UILabel!
    
    override func awakeFromNib() {
        //print("account table view cell")
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //function for the image icon in tabel view cell
    func forAccountTabelViewImage(image : UIImage){
        accountTableViewImage.image = image
    }
    
    //function for the lable in the table view cell
    func forAccountTabelViewLabel(text : String){
        accountTableViewText.text = text
    }
}
