//
//  AccountVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/03/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class AccountVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource{

    //outlets of all the elements
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var accountTableViewOutlet: UITableView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    let imageDelegate = UIImagePickerController()
    
    //table cell name and images declaration
    let tableCellArray = [["Track Order","Size Cart","Notifications","Share Locator"],["Country","Language","About US","FAQ","Shipping & Returns"]]
    let tableCellImages = [[#imageLiteral(resourceName: "trackOrder"), #imageLiteral(resourceName: "size-2"), #imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "locator")], [#imageLiteral(resourceName: "country"), #imageLiteral(resourceName: "language"), #imageLiteral(resourceName: "aboutUS") , #imageLiteral(resourceName: "faq"), #imageLiteral(resourceName: "shipping")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //make the image view round
        imageDelegate.delegate = self
        imageOutlet.layer.cornerRadius = imageOutlet.frame.height/2
        imageOutlet.clipsToBounds = true
        
        //add and enable the tap recognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadThePhoto(tapGestureRecognizer:)))
        imageOutlet.isUserInteractionEnabled = true
        imageOutlet.addGestureRecognizer(tapGestureRecognizer)
        
        //initialize the table view delegate and data source
        accountTableViewOutlet.delegate = self
        accountTableViewOutlet.dataSource = self
        
        //create and register the nib
        let nib = UINib(nibName: "AccountTableViewCell", bundle: nil)
        accountTableViewOutlet.register(nib, forCellReuseIdentifier: "AccountTableViewCell")
        
    }
    
    //function to upload the photp
    @objc open func uploadThePhoto(tapGestureRecognizer : UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        imageDelegate.allowsEditing = true
        imageDelegate.sourceType = .photoLibrary
        present(imageDelegate, animated: true, completion: nil)
    }

    //function to pick the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageChoosed = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageOutlet.contentMode = .scaleAspectFit
            imageOutlet.image = imageChoosed
        }
        dismiss(animated: true, completion: nil)
    }
    
    //dismiss the view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Account table view delegate and data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCellArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = accountTableViewOutlet.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
        cell.forAccountTabelViewLabel(text: tableCellArray[indexPath.section][indexPath.row])
        cell.forAccountTabelViewImage(image: tableCellImages[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableCellArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    //action of sign In button
    @IBAction func signInButtonTapped(_ sender: Any) {
    }
    
    //action of join button
    @IBAction func joinButtonTapped(_ sender: Any) {
    }

}
