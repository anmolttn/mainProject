//
//  JoinVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 24/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInbtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.popToRootViewController(animated: true)
        //self.navigationController?.popToViewController(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func signUpbtnTapped(_ sender: Any) {
    }
    
}
