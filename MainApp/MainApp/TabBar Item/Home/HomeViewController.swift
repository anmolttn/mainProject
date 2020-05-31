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
    var defaultImage = #imageLiteral(resourceName: "NotFound")
    
    @IBOutlet weak var homeTableView: UITableView!
    var sectionHeader = [nil,"Best Drama","Popular","Highest Rated", "Best Drama Movies Of 2020"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register the nib file of table view cell
        let nib = UINib(nibName: "MoviesDataTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "MoviesDataTableViewCell")
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        homeNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self

    }
    
    //home navigation bar
    func homeNavigationBar(){
        navigationItem.title = "Home"
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchMovie))

        navigationItem.rightBarButtonItems = [search]
    }
    
    @objc func searchMovie(){
    }
}

//extension for the table view delagate and data source

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeader.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sectionHeader[section] == nil{
            return 0
        }else{
            return 50

        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 400
        }else{
            return 300
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "MoviesDataTableViewCell", for: indexPath) as! MoviesDataTableViewCell
        cell.Cellview = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MoviesDataTableViewCell{
            
        cell.moviesCollectionView.tag = indexPath.section
        cell.moviesCollectionView.reloadData()
            
        }
    }
}


