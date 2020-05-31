//
//  BackgroundColorViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 30/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class BackgroundColorViewController: UIViewController {

    @IBOutlet weak var backgroundColorView: UIView!
    
    let colorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()

       self.backgroundColorView.addSubview(colorPicker)
       colorPicker.setViewColor(UIColor.red)
        
    }

    @IBAction func backgroundColorBtntapped(_ sender: Any) {
        
        ThemeViewController.backgroundColour = colorPicker.color
        print(colorPicker.color!)
        self.navigationController?.popViewController(animated: true)
    }
    

}
