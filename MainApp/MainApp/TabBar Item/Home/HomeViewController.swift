//
//  HomeVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 11/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let api = ApiStruct()
    var movieArray  : MoviesData?
    var defaultImage = #imageLiteral(resourceName: "tvAppLogo")
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var sectionHeader = [nil,"Movies","Popular","Best Drama"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the nib file of table view cell
        let nib = UINib(nibName: "MovieTrendingTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "MovieTrendingTableViewCell")
        
        let nib2 = UINib(nibName: "ActorNameTableViewCell", bundle: nil)
               homeTableView.register(nib2, forCellReuseIdentifier: "ActorNameTableViewCell")
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        getData()
        

    }
    
    //function to get the moview data
    func getData(){
        api.getTrendingMovieData { [weak self] (response) in
            if let response = response as? MoviesData{
                self?.movieArray = response
            }
        }
    }
}

//extension for the table view delagate and data source

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 300
        }else{
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "MovieTrendingTableViewCell", for: indexPath) as! MovieTrendingTableViewCell
            return cell
        }
        else{
            let cell = homeTableView.dequeueReusableCell(withIdentifier: "ActorNameTableViewCell", for: indexPath) as! ActorNameTableViewCell
            return cell
        }
    }
}
