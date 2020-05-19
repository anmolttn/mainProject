//
//  CountryAndLanguage.swift
//  MainApp
//
//  Created by Anmol Chauhan on 19/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation

//structure for the data store of the country
struct CountryItem {
var countryName: String = ""
var countryImage: String = ""

init(countryName: String, countryImage: String) {
    self.countryName = countryName
    self.countryImage = countryImage
    }
}

//enum for the selection of the the country and language cell
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
