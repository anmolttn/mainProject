//
//  EmployeesListViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import Alamofire

class EmployeesListViewController: UIViewController {

    var empArray : Employees?
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        
        let nib = UINib(nibName: "EmployeeListTableViewCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "empListCell")

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
                        print("data show of lisyt view")
                    }catch{
                        print(error.localizedDescription)
                    }
                }
                self?.employeeTableView.reloadData()
            }
        }
    }

    extension EmployeesListViewController : UITableViewDelegate, UITableViewDataSource{
        
        //MARK: Table view delegate and data source

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.empArray?.data?.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = employeeTableView.dequeueReusableCell(withIdentifier: "empListCell", for: indexPath) as! EmployeeListTableViewCell
            if let data1 = self.empArray?.data{

                cell.empName.text = "Name : \(data1[indexPath.row].employeeName ?? "")"
                
            }
            return cell
            }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
    }
