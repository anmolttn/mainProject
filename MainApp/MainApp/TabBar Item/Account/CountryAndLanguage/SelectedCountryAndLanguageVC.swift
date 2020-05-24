//
//  SelectedCountryAndLanguageVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit


class SelectedCountryAndLanguageVC: UIViewController {
        
    
    var countries : [CountryItem] = []
    var defaultImageForCountry = #imageLiteral(resourceName: "faq")
    let api = ApiStruct()

    @IBOutlet weak var selectTableViewOutlet: UITableView!
    
    var languageName = Locale.isoLanguageCodes.compactMap {
    Locale.current.localizedString(forLanguageCode: $0) }.sorted()
    
    //deelegate of the protocol declaration
    var delegateForCountry : CountryDataProtocol!
    var delegateForLanguage : LanguageDataprotocol!
    
    public static var selectedCell : cellSelection = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call the api function
        getCountryData()
    
        //delegate and data source of table view
        selectTableViewOutlet.delegate = self
        selectTableViewOutlet.dataSource = self
        
        
        //register the nib file of country and language table view cell
        let nib = UINib(nibName: "CountryListTableViewCell", bundle: nil)
        selectTableViewOutlet.register(nib, forCellReuseIdentifier: "CountryListTableViewCell")
        let nib1 = UINib(nibName: "LanguageListTableViewCell", bundle: nil)
        selectTableViewOutlet.register(nib1, forCellReuseIdentifier: "LanguageListTableViewCell")

    }
    
    
    func getCountryData(){
        api.getCountriesData { (response) in
            if let response = response as? [CountryItem]{
                self.countries = response
            }
            self.selectTableViewOutlet.reloadData()
        }
    }
}


extension SelectedCountryAndLanguageVC : UITableViewDelegate,UITableViewDataSource{
    
    //MARK: Account table view delegate and data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SelectedCountryAndLanguageVC.selectedCell == .Country{
            return self.countries.count
        }
        else {
            return languageName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if SelectedCountryAndLanguageVC.selectedCell == .Country{
            let cell = selectTableViewOutlet.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
            //set the country image and country name after the selection from country list
            cell.nameOfTheCountry(text: self.countries[indexPath.row].countryName)
            if let url = URL(string: "https://www.countryflags.io/\(countries[indexPath.row].countryImage)/shiny/64.png"){
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.flagImage(image: UIImage(data: data) ?? self.defaultImageForCountry)
                            cell.countryFlagImage.contentMode = .scaleAspectFit
                        }
                    }
                }.resume()
            }
                else{
                print("error in loading data")
                    }
                return cell
        }
            
        else{
        
        let cell = selectTableViewOutlet.dequeueReusableCell(withIdentifier: "LanguageListTableViewCell", for: indexPath) as! LanguageListTableViewCell
            //set the selected language from the language list
        cell.nameOfTheLanguage(text: languageName[indexPath.row])
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectTableViewOutlet.deselectRow(at: indexPath, animated: true)
        
        //selection of the table cell
        if SelectedCountryAndLanguageVC.selectedCell == .Country{
        
            
        //pass the data in the delegate
        delegateForCountry.passCountryData(countryName: countries[indexPath.row].countryName, countryImage: countries[indexPath.row].countryImage)
        }
        
        //selection of the table cell
        if SelectedCountryAndLanguageVC.selectedCell == .Language{
            
            //pass the data in the delagate
            delegateForLanguage.passLanguageData(languageName: languageName[indexPath.row])
            }
        self.navigationController?.popViewController(animated: true)
        
    }
    
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    
}
