//
//  JoinVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 24/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class JoinViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var securityQuestionTextField: UITextField!
    
    var register = ManualLogin()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signUpbtnTapped(_ sender: Any) {
        
        register.signupUser(username : userNameTextField.text ?? "", Password : passwordTextField.text ?? "", confirmPassword : confirmPasswordTextField.text ?? "", securityQues: securityQuestionTextField.text ?? "", view: self)
    }
}
