//
//  SelectedCountryAndLanguageVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 12/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

//structure for the data store of the country
struct CountryItem {
var countryName: String = ""
var countryImage: String = ""

init(countryName: String, countryImage: String) {
    self.countryName = countryName
    self.countryImage = countryImage
    }
}

enum cellSelection {
    case Country
    case Language
    case None
}

//protocol for country data
public protocol CountryDataProtocol{
    
    func passCountryData(countryName : String , countryImage : String)
    
}

//protocol for language data
public protocol LanguageDataprotocol{
    
    func passLanguageData(languageName : String)
}

class SelectedCountryAndLanguageVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
        
    
    var countries : [CountryItem] = []
    var image123 = #imageLiteral(resourceName: "country")

    @IBOutlet weak var selectTableViewOutlet: UITableView!
    
    var languageName = Locale.isoLanguageCodes.compactMap {
    Locale.current.localizedString(forLanguageCode: $0) }.sorted()
    
    //deelegate of the protocol declaration
    var delegateForCountry : CountryDataProtocol!
    var delegateForLanguage : LanguageDataprotocol!
    
    public static var selectedCell : cellSelection = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(languageName)
        //call the api function
        getData()
        
        //reload the country and language table
        selectTableViewOutlet.reloadData()
        
        //delegate adn data source of table view
        selectTableViewOutlet.delegate = self
        selectTableViewOutlet.dataSource = self
        
        
        //register the nib file of country and language table view cell
        let nib = UINib(nibName: "CountryListTableViewCell", bundle: nil)
        selectTableViewOutlet.register(nib, forCellReuseIdentifier: "CountryListTableViewCell")
        let nib1 = UINib(nibName: "LanguageListTableViewCell", bundle: nil)
        selectTableViewOutlet.register(nib1, forCellReuseIdentifier: "LanguageListTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //selectTableViewOutlet.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
        //return languageName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if SelectedCountryAndLanguageVC.selectedCell == .Country{
            
            let cell = selectTableViewOutlet.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as! CountryListTableViewCell
            cell.nameOfTheCountry(text: self.countries[indexPath.row].countryName)
            if let url = URL(string: "https://www.countryflags.io/\(countries[indexPath.row].countryImage)/shiny/64.png"){
            //print("image -------",  (countries[0].countryImage))
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data {
                        DispatchQueue.main.async {
                            cell.flagImage(image: UIImage(data: data) ?? self.image123)
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
        cell.nameOfTheLanguage(text: languageName[indexPath.row])
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectTableViewOutlet.deselectRow(at: indexPath, animated: true)
        
        
        if SelectedCountryAndLanguageVC.selectedCell == .Country{
        
        delegateForCountry.passCountryData(countryName: countries[indexPath.row].countryName, countryImage: countries[indexPath.row].countryImage)
        }
        
        
        if SelectedCountryAndLanguageVC.selectedCell == .Language{
            
            delegateForLanguage.passLanguageData(languageName: languageName[indexPath.row])
            }
        self.navigationController?.popViewController(animated: true)
        
    }
    
       
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
    
    
    //function to get the data from the api
    func getData(){
        //print("abc function called")
          let api = APIForCountryAndLanguage()
         self.selectTableViewOutlet.reloadData()
          api.getData { (response , error ) in
            //print(response)
              if let getResponse = response as? [String : String]{
                //print(getResponse)
                  for (key , value) in getResponse {
                self.countries.append(CountryItem(countryName: value, countryImage: key))
                      }
              }
              else{
                print("error in get response")
            }
          }
      }
}
