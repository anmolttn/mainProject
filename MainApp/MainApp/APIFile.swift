//
//  APIFile.swift
//  MainApp
//
//  Created by Anmol Chauhan on 16/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation
import Alamofire

struct APIForCountryAndLanguage {
    
    let config = URLSessionConfiguration.default
    //createing a session
    let session = URLSession(configuration: .default)
    
    func getCountriesData(completionBlock: @escaping(_ response: Any?, _ error: Error?) -> Void){
        //creting the request
        let request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/hjnilsson/country-flags/master/countries.json")!)
        //crete data task
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let _ = response as? HTTPURLResponse else {
                return
            }
            do{
            if error == nil{
                    let countriesName = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : String]
                //let sortedCountriesName = countriesName?.sorted{ $0.1 < $1.1 }
                completionBlock(countriesName , nil)
                //print(countriesName)
                
                }
        }
            catch{
                print("error in fething the data")
                completionBlock(nil , error)
            }
        }.resume()
}
}

struct APIForEmployee {
  
    func getEmployeeData(){
        AF.request("http://dummy.restapiexample.com/api/v1/employees", method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseData { response in
                switch response.result{
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let data):
                    do{
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let employeeData = try decoder.decode(Employees.self, from: data)
                        EmployeeDataVC.empArray = employeeData
                        //print("empdata --- >>>>",employeeData)
                        //print("emparray data --",EmployeeDataVC.empArray)
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
