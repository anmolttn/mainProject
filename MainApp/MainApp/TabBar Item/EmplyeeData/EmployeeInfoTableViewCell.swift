//
//  EmployeeInfoTableViewCell.swift
//  MainApp
//
//  Created by Anmol Chauhan on 17/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
class EmployeeInfoTableViewCell: UITableViewCell {

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
//
//    func empIDCell(empI : String){
//        empID.text = empI
//    }
//    func empDataInCell(data : EmployeeStruct){
//        empID.text = data.id
//        empName.text = data.employeeName
//        empSalary.text = data.employeeSalary
//        empAge.text = data.employeeAge
//    }
    
}
