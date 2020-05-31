//
//  ForgetPasswordViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 31/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var captchaTextField: UITextField!
    @IBOutlet weak var setNewPassword: UITextField!
    
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

    

    @IBAction func resetPasswordBtnTapped(_ sender: Any) {
        
        let dob = dobTextField.text!
        let captcha = captchaTextField.text!
        let newPassword = setNewPassword.text!
        
        let dobStored = UserDefaults.standard.string(forKey: "dob")
        
        if dob == dobStored && captcha == "ic8"{
            
            UserDefaults.standard.set(newPassword, forKey: "newPassword")
//            UserDefaults.standard.synchrinize()
            showAlertMsg(msg: "Password Reset!")
        }
        else if dob != dobStored {
            showAlertMsg(msg: "Wrong Date Of Birth")
        }
        else if captcha != "ic8"{
            showAlertMsg(msg: "Wrong Captcha")
        }
    }
    
    func showAlertMsg(msg: String) {
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default){
            action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
