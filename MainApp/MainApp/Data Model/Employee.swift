//
//  Employee.swift
//  MainApp
//
//  Created by Anmol Chauhan on 19/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

struct EmployeeStruct : Codable {
    let id : String?
    let employeeName : String?
    let employeeSalary : String?
    let employeeAge : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
    }
}

struct Employees : Codable {
    let status : String?
    let data : [EmployeeStruct]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }
}
