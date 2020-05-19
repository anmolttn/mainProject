//
//  EmplyeeDataVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 15/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class EmployeeDataVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    let api = APIForEmployee()
    public static var empArray : Employees?

    @IBOutlet weak var employeeDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDataTableView.delegate = self
        employeeDataTableView.dataSource = self
        
        let nib = UINib(nibName: "EmployeeInfoTableViewCell", bundle: nil)
        employeeDataTableView.register(nib, forCellReuseIdentifier: "empCell")

        api.getEmployeeData()
        employeeDataTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeDataVC.empArray?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeDataTableView.dequeueReusableCell(withIdentifier: "empCell", for: indexPath) as! EmployeeInfoTableViewCell
        if let data1 = EmployeeDataVC.empArray?.data{
            cell.empID.text = "ID : \(data1[indexPath.row].id ?? "")"
            cell.empName.text = "Name : \(data1[indexPath.row].employeeName ?? "")"
            cell.empSalary.text = "Salary : \(data1[indexPath.row].employeeSalary ?? "")"
            cell.empAge.text = "Age : \(data1[indexPath.row].employeeAge ?? "")"

            //cell.empIDCell(empI: data1[indexPath.row].id!)
            //cell.empDataInCell(data: data1[indexPath.row])
        }
        return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

