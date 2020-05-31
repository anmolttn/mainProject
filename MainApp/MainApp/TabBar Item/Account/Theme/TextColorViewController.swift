//
//  TextColorViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 30/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import SwiftHSVColorPicker

class TextColorViewController: UIViewController {

    @IBOutlet weak var textColorView: UIView!
    
    let textColorPicker = SwiftHSVColorPicker(frame: CGRect(x: 20, y: 30, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textColorView.addSubview(textColorPicker)
        textColorPicker.setViewColor(UIColor.red)
    }
    
    @IBAction func fontColorBtnTapped(_ sender: Any) {
        
        ThemeViewController.textColor = textColorPicker.color
        self.navigationController?.popViewController(animated: true)

    }
    
}
