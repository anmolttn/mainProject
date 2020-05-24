//
//  ApiManager.swift
//  MainApp
//
//  Created by Anmol Chauhan on 21/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

struct ApiStruct {
    
    func getCountriesData(completionBlock : @escaping (_ response : Any?) -> ()){
             print("function called")
             //createing a session
             _ = URLSession(configuration: .default)
             //creting the request
             let request = URLRequest(url: URL(string: "https://raw.githubusercontent.com/hjnilsson/country-flags/master/countries.json")!)
             //crete data task
            var countries : [CountryItem] = []
             _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
                 print("teask created")
                 guard let data = data, let _ = response as? HTTPURLResponse else {
                     return
                 }
                 do{
                 if error == nil{
                     print("no error")
                     let countriesName = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String : String]
                     let sortedCountriesName = countriesName?.sorted{ $0.1 < $1.1 }
                     for (key , value) in sortedCountriesName!{
                        countries.append(CountryItem(countryName: value, countryImage: key))
                         }
                     }
                     DispatchQueue.main.async {
                         completionBlock(countries)
                     }
             }
                 catch{
                     print("error in fething the data",error.localizedDescription)
                 }
             }.resume()
     }
    
    func getEmployeeData(completionBlock : @escaping (_ response : Any?) -> ()){
           _ = URLSessionConfiguration.default
           let request = URLRequest(url: URL(string:"http://dummy.restapiexample.com/api/v1/employees")!)
            var empArray : Employees?
           _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let data = data , let _ = response as? HTTPURLResponse else{
                   return
               }
               do{
                   if error == nil{
                       let decoder = JSONDecoder()
                       //decoder.keyDecodingStrategy = .useDefaultKeys
                       let employeeData = try decoder.decode(Employees.self, from: data)
                    empArray.self = employeeData
                       print("data show of card view")
                       print("empdata --- >>>>",employeeData)
                       //print("emparray data --"self.empArray)
                       DispatchQueue.main.async {
                           completionBlock(empArray)
                       }
                   }
               }
               catch{
                   print(error.localizedDescription)
               }
           }.resume()
       }
    
    
    func getTrendingMovieData(completionBlock : @escaping (_ response : Any?) -> ()){
        _ = URLSessionConfiguration.default
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=820016b7116f872f5f27bf56f9fdfb66")!)
        var movieArray : MoviesData?
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
        var movieArray : MoviesData?
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
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
    
    func getBestDramaMoviesData(completionBlock : @escaping (_ response : Any?) -> ()){
           _ = URLSessionConfiguration.default
           var movieArray : MoviesData?
           let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
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
    func getHighestRatedMoviesdata(completionBlock : @escaping (_ response : Any?) -> ()){
        _ = URLSessionConfiguration.default
        var movieArray : MoviesData?
        let request = URLRequest(url: URL(string: "http://api.themoviedb.org/3/discover/movie?certification_country=US&certification=R&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
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
    func getYear2020MoviesData(completionBlock : @escaping (_ response : Any?) -> ()){
        _ = URLSessionConfiguration.default
        var movieArray : MoviesData?
        let request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/discover/movie?primary_release_year=2020&sort_by=vote_average.desc&api_key=820016b7116f872f5f27bf56f9fdfb66")!)
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
    
    
}
