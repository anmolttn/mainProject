//
//  ButtonColorViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 30/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class ButtonColorViewController: UIViewController {

    @IBOutlet weak var buttonColorView: UIView!

    let buttonColorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 300))
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       self.buttonColorView.addSubview(buttonColorPicker)
        buttonColorPicker.setViewColor(UIColor.red)
    }
    
    @IBAction func buttonColorBtnTapped(_ sender: Any) {

        ThemeViewController.buttonColour = buttonColorPicker.color
            self.navigationController?.popViewController(animated: true)
    }
    

}
