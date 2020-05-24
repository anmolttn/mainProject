//
//  EmplyeeDataVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 15/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class EmployeesCardViewController: UIViewController {
        
    var empArray : Employees?
    let api = ApiStruct()

    @IBOutlet weak var employeeDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDataTableView.delegate = self
        employeeDataTableView.dataSource = self
        
        let nib = UINib(nibName: "EmployeeCardTableViewCell", bundle: nil)
        employeeDataTableView.register(nib, forCellReuseIdentifier: "empDetailCell")

        //call the api function
        getEmpData()
        
    }
    
    //function to get the employee data
    func getEmpData(){
        api.getEmployeeData { [weak self] (response) in
            if let response = response as? Employees{
                self?.empArray = response
            }
            self?.employeeDataTableView.reloadData()
        }
    }
}

extension EmployeesCardViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Table view delegate and data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.empArray?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeDataTableView.dequeueReusableCell(withIdentifier: "empDetailCell", for: indexPath) as! EmployeeCardTableViewCell
        if let data1 = self.empArray?.data{
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
        return 130
    }
}
