//
//  ApiManager.swift
//  MainApp
//
//  Created by Anmol Chauhan on 21/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

struct ApiStruct {
    func getTrendingMovieData(completionBlock : @escaping (_ response : Any?) -> ()){
        _ = URLSessionConfiguration.default
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        var movieArray : MoviesData?
        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data , let _ = response as? HTTPURLResponse else{
                return
            }
            do{
                if error == nil{
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .useDefaultKeys
                    let mData = try decoder.decode(MoviesData.self, from: data)
                    movieArray.self = mData
                    print("data fetch")
                }
                DispatchQueue.main.async {
                    completionBlock(movieArray)
                }
            }catch{
                print("error",error.localizedDescription)
            }
        }.resume()
    }
    
    func getPopularMovieData(completionBlock : @escaping (_ response : Any?) -> ()){
        _ = URLSessionConfiguration.default
        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        var movieArray : MoviesData?
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        //let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data , let _ = response as? HTTPURLResponse else{
                return
            }
            do{
                if error == nil{
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .useDefaultKeys
                    let mData = try decoder.decode(MoviesData.self, from: data)
                    movieArray.self = mData
                    print("data fetch")
                }
                DispatchQueue.main.async {
                    completionBlock(movieArray)
                }
            }catch{
                print("error",error.localizedDescription)
            }
        }.resume()
    }
    
    func getEmployeeData(completionBlock : @escaping () -> ()){
           _ = URLSessionConfiguration.default
           let request = URLRequest(url: URL(string:"http://dummy.restapiexample.com/api/v1/employees")!)
           _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let data = data , let _ = response as? HTTPURLResponse else{
                   return
               }
               do{
                   if error == nil{
                       let decoder = JSONDecoder()
                       //decoder.keyDecodingStrategy = .useDefaultKeys
                       let employeeData = try decoder.decode(Employees.self, from: data)
                       //self?.empArray = employeeData
                       print("data show of card view")
                       print("empdata --- >>>>",employeeData)
                       //print("emparray data --"self.empArray)
                       DispatchQueue.main.async {
                           completionBlock()
                       }
                   }
               }
               catch{
                   print(error.localizedDescription)
               }
           }.resume()
       }
}
