//
//  AccountVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 20/03/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //default name of country and language
    var countryName = "India"
    var countryImage = "IN"
    var dummy = #imageLiteral(resourceName: "US")
    var languageName = "HIN"


    //outlets of all the elements
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var accountTableViewOutlet: UITableView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    

    //outlet of the view of signup and join button
    @IBOutlet weak var insideViewOutlet: UIView!
    
    
    let imageDelegate = UIImagePickerController()
    
    //table cell name and images declaration
    let tableCellArray = [["Location","Movies","Notifications","My Circle/Employees"],["Country","Language","About US","FAQ","Change Theme"]]
    let tableCellImages = [[#imageLiteral(resourceName: "trackOrder"), #imageLiteral(resourceName: "size-2"), #imageLiteral(resourceName: "notification"),#imageLiteral(resourceName: "locator")], [#imageLiteral(resourceName: "country"), #imageLiteral(resourceName: "language"), #imageLiteral(resourceName: "aboutUS") , #imageLiteral(resourceName: "faq"), #imageLiteral(resourceName: "shipping")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        insideViewOutlet.layer.cornerRadius = 10
        
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
        let nib1 = UINib(nibName: "CountryTableCell", bundle: nil)
        accountTableViewOutlet.register(nib1, forCellReuseIdentifier: "CountryTableCell")
        let nib2 = UINib(nibName: "LanguageTableCell", bundle: nil)
        accountTableViewOutlet.register(nib2, forCellReuseIdentifier: "LanguageTableCell")
        
    }
    
    //to reload the data in table view for country cell
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        accountTableViewOutlet.reloadData()
        
    }
    
    //function to upload the photo
    @objc open func uploadThePhoto(tapGestureRecognizer : UITapGestureRecognizer){
        _ = tapGestureRecognizer.view as! UIImageView
        imageDelegate.allowsEditing = true
        imageDelegate.sourceType = .photoLibrary
        present(imageDelegate, animated: true, completion: nil)
    }

    //function to pick the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageChoosed = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            imageOutlet.contentMode = .scaleAspectFill
            imageOutlet.image = imageChoosed
        }
        dismiss(animated: true, completion: nil)
    }
    
    //dismiss the view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //action of sign In button
    @IBAction func signInButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //action of join button
    @IBAction func joinButtonTapped(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "JoinVC") as! JoinViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//extension for table view delegate and data source
extension AccountViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCellArray[section].count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if indexPath.section == 1 && indexPath.row == 0 {
             let cell = accountTableViewOutlet.dequeueReusableCell(withIdentifier: "CountryTableCell") as!  CountryTableCell
             cell.countryLogo(image: tableCellImages[1][0])
             cell.countryText(text: tableCellArray[1][0])
            //get the image in the cell
            if let url = URL(string: "https://www.countryflags.io/\(countryImage)/shiny/64.png"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.countryFlag(image1: UIImage(data: data) ?? self.dummy)
                            cell.countryFlagImage.contentMode = .scaleAspectFit
                        }
                    }
                }.resume()
            }
            else{
                print("error in loading data")
            }
            cell.nameOfTheCountry(text1: String(countryName).prefix(3).uppercased())
             return cell
         }
        else if indexPath.section == 1 && indexPath.row == 1{
             let cell = accountTableViewOutlet.dequeueReusableCell(withIdentifier: "LanguageTableCell") as! LanguageTableCell
            cell.imageOfLanguageIcon(image: tableCellImages[1][1])
            cell.labelOfTheLanguage(text: tableCellArray[1][1])
            cell.nameOfTheLanguage(text1: String(languageName).prefix(3).uppercased())
            return cell
         }
         else{
        
            let cell = accountTableViewOutlet.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
            cell.forAccountTabelViewLabel(text: tableCellArray[indexPath.section][indexPath.row])
            cell.forAccountTabelViewImage(image: tableCellImages[indexPath.section][indexPath.row])
        
            return cell

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableCellArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        accountTableViewOutlet.deselectRow(at: indexPath, animated: true)

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if indexPath.section == 0 && indexPath.row == 0{
            let vc = storyBoard.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 3{
            let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeesViewController") as! EmployeesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            let vc = storyBoard.instantiateViewController(withIdentifier: "SelectedCountryAndLanguageVC") as! SelectedCountryAndLanguageVC
            SelectedCountryAndLanguageVC.selectedCell = .Country
            vc.delegateForCountry = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
         if indexPath.section == 1 && indexPath.row == 1 {
            let vc = storyBoard.instantiateViewController(withIdentifier: "SelectedCountryAndLanguageVC") as! SelectedCountryAndLanguageVC
            SelectedCountryAndLanguageVC.selectedCell = .Language
            vc.delegateForLanguage = self
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    

}
//extension for protocol
extension AccountViewController : CountryDataProtocol , LanguageDataprotocol{
    
    func passCountryData(countryName: String , countryImage : String){
        self.countryImage = countryImage
        self.countryName = countryName
        
    }
    func passLanguageData(languageName: String) {
        self.languageName = languageName
    }
}
