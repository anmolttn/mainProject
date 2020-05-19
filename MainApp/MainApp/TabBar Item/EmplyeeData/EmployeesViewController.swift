//
//  EmplyeeDataVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 15/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import Alamofire


class EmployeesViewController: UIViewController {
        
    var empArray : Employees?

    @IBOutlet weak var employeeDataTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDataTableView.delegate = self
        employeeDataTableView.dataSource = self
        
        let nib = UINib(nibName: "EmployeeInfoTableViewCell", bundle: nil)
        employeeDataTableView.register(nib, forCellReuseIdentifier: "empCell")

        getEmployeeData()
    }
    
    //function to get the employee data
    func getEmployeeData(){
    AF.request("http://dummy.restapiexample.com/api/v1/employees", method: .get, parameters: nil, encoding: URLEncoding.default)
        .responseData { [weak self] response in
            switch response.result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let employeeData = try decoder.decode(Employees.self, from: data)
                    self?.empArray = employeeData
                    print("data show")
                    //print("empdata --- >>>>",employeeData)
                    //print("emparray data --"self.empArray)
                }catch{
                    print(error.localizedDescription)
                }
            }
            self?.employeeDataTableView.reloadData()
        }
    }
}

extension EmployeesViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: Table view delegate and data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.empArray?.data?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeDataTableView.dequeueReusableCell(withIdentifier: "empCell", for: indexPath) as! EmployeeInfoTableViewCell
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
        return 150
    }
}
