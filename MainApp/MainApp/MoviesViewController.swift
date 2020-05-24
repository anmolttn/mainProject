//
//  MoviesViewController.swift
//  
//
//  Created by Anmol Chauhan on 23/05/20.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUINavigation()
        // Do any additional setup after loading the view.
    }
    
    private func setupUINavigation() {
        // custom navigation bar
        self.customNavigationBar()
        // add logo to navigationbar
       // self.createLogoTitleView()
        
        // add profile button to left navigation bar
        //self.createLeftBarButton()
        
        // add search button to right navigation bar
        //self.createRightBarButton()
    }
    
    
    private func customNavigationBar() {
        self.navigationItem.title = "Home"
           // set background color for navigation bar
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        // create shadow below navigation bar
        self.navigationController?.navigationBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.23).cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 20.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 20.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.6
        self.navigationController?.navigationBar.layer.masksToBounds = false
       }
    
    private func setupLayoutCollectionView() {
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .vertical
           self.collectionView.collectionViewLayout = layout
           self.collectionView.backgroundColor = .white
//           self.collectionView.register(MovieCollectionViewCell.self, self.collectionView)
//           self.collectionView.register(HomeCategoryCollectionCell.self, self.collectionView)
//           self.collectionView.register(HomePopularCollectionCell.self, self.collectionView)
//           self.collectionView.register(HomeTopRatedCollectionCell.self, self.collectionView)
//           self.collectionView.register(HomeUpcomingCollectionCell.self, self.collectionView)
//           self.collectionView.registerHeader(HomeHeaderSection.self, self.collectionView)
       }
       

}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
