//
//  ThemeViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 30/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import iOSDropDown
import SwiftHSVColorPicker

class ThemeViewController: UIViewController {

    @IBOutlet weak var fontTextDropDown: DropDown!
    
    static var backgroundColour : UIColor?
    static var textColor : UIColor?
    static var buttonColour : UIColor?
    
    var fontType : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontTextDropDown.selectedRowColor = .clear
        fontTextDropDown.listHeight = 250
        
        fontStyleSelected()        

    }
    
    //function to set the font
    func fontStyleSelected() {
        fontTextDropDown.optionArray = UIFont.familyNames
        fontTextDropDown.didSelect { (SelectedFont, Index, id) in
            self.fontType = SelectedFont
        }
    }


    //action for Font Color
    @IBAction func fontColorBtnTapped(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "TextColorViewController")
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    //action for background color
    @IBAction func backgroundColorBtnTappe(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "BackgroundColorViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //action for button background coloer
    @IBAction func buttonBackgroundBtnTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ButtonColorViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //action for apply the changes 
    @IBAction func applyThemeBtnTapped(_ sender: UIButton) {
        
        let selectedFont = UILabel.appearance()
        let selectedButton = UIButton.appearance()
        let SelectedView = UIView.appearance()
        
        selectedFont.font = UIFont(name: self.fontType ?? "Times New Roman", size: 18)
        selectedButton.titleLabel?.font = UIFont(name: self.fontType ?? "Times New Roman", size: 18)
        SelectedView.backgroundColor = ThemeViewController.backgroundColour ?? UIColor.white
        selectedFont.textColor = ThemeViewController.textColor ?? UIColor.black
        selectedButton.backgroundColor = ThemeViewController.buttonColour ?? UIColor.white
        
        
        self.navigationController?.popViewController(animated: true)
    }
}
