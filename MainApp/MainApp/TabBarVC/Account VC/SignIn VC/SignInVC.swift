//
//  SignInVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 24/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedSignUpBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "JoinVC") as! JoinVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tappedLogInBtn(_ sender: Any) {
    }
    @IBAction func tappedForgetPasswordBtn(_ sender: Any) {
    }
    
}
