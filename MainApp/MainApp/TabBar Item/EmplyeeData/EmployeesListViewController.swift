//
//  EmployeesListViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class EmployeesListViewController: UIViewController {

    var empArray : Employees?
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeTableView.delegate = self
        employeeTableView.dataSource = self
        
        let nib = UINib(nibName: "EmployeeListTableViewCell", bundle: nil)
        employeeTableView.register(nib, forCellReuseIdentifier: "empListCell")

        //call the api function
        getEmployeeData{
            self.employeeTableView.reloadData()
        }
    }
    
    //function to get the employee data
    func getEmployeeData(completionBlock : @escaping () -> ()){
        _ = URLSessionConfiguration.default
            let request = URLRequest(url: URL(string:"http://dummy.restapiexample.com/api/v1/employees")!)
        _ = URLSession.shared.dataTask(with: request) { [ weak self ] (data, response, error) in
            guard let data = data , let _ = response as? HTTPURLResponse else{
                    return
                }
                do{
                    if error == nil{
                        let decoder = JSONDecoder()
                        //decoder.keyDecodingStrategy = .useDefaultKeys
                        let employeeData = try decoder.decode(Employees.self, from: data)
                        self?.empArray = employeeData
                        print("data show of List view")
                        //print("empdata --- >>>>",employeeData)
                        //print("emparray data --"self.empArray)
                    }
                    DispatchQueue.main.async {
                        completionBlock()
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }.resume()
            self.employeeTableView.reloadData()
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
