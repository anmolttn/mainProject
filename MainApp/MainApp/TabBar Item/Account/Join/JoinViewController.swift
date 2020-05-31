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
    @IBOutlet weak var dobTextField: UITextField!
    
    let datePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        showDatePicker()
    }
    
    func showDatePicker() {
        
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

         dobTextField.inputAccessoryView = toolbar
         dobTextField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dobTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @IBAction func logInbtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        _ = storyBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpbtnTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        let dobUser = dobTextField.text!
        
        //check for empty field
        if (userName.isEmpty || password.isEmpty || confirmPassword.isEmpty || dobUser.isEmpty){
            //display alert message
            displayAlertMessage(message: "All fields are required")
            
            return
        }
        //check if password match
        if password != confirmPassword {
            //display alert message
            displayAlertMessage(message: "Password do not match")
            return
        }
        
        //store data
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.set(dobUser, forKey: "dob")
        UserDefaults.standard.synchronize();
        
        //display alert message with confirmation
        let myAlert = UIAlertController(title: "Alert", message: "Registration is Successful", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayAlertMessage(message : String){
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
}
