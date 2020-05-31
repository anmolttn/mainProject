//
//  EmployeesViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
 
    @IBOutlet weak var EmployeeCardView: UIView!
    @IBOutlet weak var EmployeeListView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        EmployeeCardView.isHidden = true
        EmployeeListView.isHidden = false
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
          
          if sender.selectedSegmentIndex == 0{
              EmployeeCardView.isHidden = true
              EmployeeListView.isHidden = false
          }
          else{
              EmployeeCardView.isHidden = false
              EmployeeListView.isHidden = true
          }
          
      }
    
}
