//
//  ForgetPasswordViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 31/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var confirmpasswordtextField: UITextField!
    @IBOutlet weak var setNewPassword: UITextField!
    @IBOutlet weak var securityQuestionTextField: UITextField!
    
    var reset = ManualLogin()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

    @IBAction func resetPasswordBtnTapped(_ sender: Any) {
        
        reset.forgetPassword(username : usernameTextField.text ?? "", password : setNewPassword.text ?? "", confirmPassword : confirmpasswordtextField.text ?? "", securityQues : securityQuestionTextField.text ?? "", view : self)
    }

}
