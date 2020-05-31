//
//  EmployeeInfoTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 17/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
class EmployeeCardTableViewCell: UITableViewCell {

    @IBOutlet weak var empImage: UIImageView!
    @IBOutlet weak var empID: UILabel!
    @IBOutlet weak var empName: UILabel!
    @IBOutlet weak var empAge: UILabel!
    @IBOutlet weak var empSalary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
