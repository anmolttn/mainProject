//
//  LoginAndSignUp.swift
//  MainApp
//
//  Created by Anmol Chauhan on 31/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import Foundation
import UIKit

protocol UserLoginAndSignUp {
    
 func signupUser(username : String, Password : String, confirmPassword : String, securityQues : String, view : UIViewController)
    func loginUSer(username: String, Password: String, view: UIViewController)
    func logoutUser(view: UIViewController)
}

var allRegisteredUsers : [[String]] = []
var user : [String] = []
var currentUser : [String] = []



class ManualLogin: UserLoginAndSignUp{
    
    //MARK: SignUp Function
    func signupUser(username: String, Password: String, confirmPassword: String, securityQues: String, view: UIViewController) {
        
        if UserDefaults.standard.object(forKey: "users") != nil{
        allRegisteredUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        user.append(username)
        user.append(Password)
        user.append(securityQues)
        
//Check for empty fields
        if username == "" || Password.isEmpty || confirmPassword.isEmpty || securityQues == ""
        {
            let alertController = UIAlertController(title: "Alert", message: "All fields are required", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
            
        }
            
//Check the passwords
        else if Password != confirmPassword {
            let alertController = UIAlertController(title: "Alert", message: "Password does not match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
//If the user is already logged in, then they need to logout to use another one
        else if  currentUser.isEmpty == false {
            let alertController = UIAlertController(title: "Alert", message: "Already Signed in", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
//If no error occurs then complete the Sign up process
        else{
    
            currentUser.removeAll()
            allRegisteredUsers.append(user)
            user.removeAll()
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allRegisteredUsers, forKey: "users")
            
            let successAlert = UIAlertController(title:"Alert", message:"Account Created SuccessFully", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
            view.navigationController?.popViewController(animated: true)
            }
            successAlert.addAction(okAction)
            view.present(successAlert, animated:true, completion:nil)
            currentUser.removeAll()
        }
        print("current user in sign up",currentUser)
        print("user in sign up",user)
        print("all user in sign up",allRegisteredUsers)
    }
    
    //MARK: Login Function
    func loginUSer(username: String, Password: String, view: UIViewController) {
        allRegisteredUsers = [["username", "password", "hello"]]
        var temp : [String]?
        let storeUserData = username
        temp?.removeAll()
        if UserDefaults.standard.object(forKey: "users") != nil{
        allRegisteredUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        
//check if the user details are exists.
        if allRegisteredUsers == [[]]
        {
            let alertController = UIAlertController(title: "Alert", message: "No user exists. Kindly SignIn", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
    
        for i in 0...allRegisteredUsers.count-1
        {
            if storeUserData == allRegisteredUsers[i][0]
            {
                temp = allRegisteredUsers[i]
            }
        }
        
        //Check for the empty fields
        if username.isEmpty || Password.isEmpty
        {
            let alertController = UIAlertController(title: "Alert", message: "Please enter all the Data", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
        
        user.append(username )
        user.append(Password)

    //If the user is already logged in with an account then they need to logout to use another one
        if currentUser.isEmpty == false {
         let alertController = UIAlertController(title: "Alert", message: "Already logged In", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
        else if temp == nil{
            let alertController = UIAlertController(title: "User does not exist", message: "No such user exits", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
            
         // Check password
        else if temp![1] != Password{
          let alertController = UIAlertController(title: "Password Incorrect", message: "Incorrect Password!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
            }

            //Complete the login process
        else{
            currentUser = user
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allRegisteredUsers, forKey: "users")
            temp?.removeAll()
            
            
            let successAlert = UIAlertController(title:"Alert", message:"Login SuccessFully", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title : "Ok", style : UIAlertAction.Style.default){ UIAction in
            view.navigationController?.popViewController(animated: true)
            }
            successAlert.addAction(okAction)
            view.present(successAlert, animated:true, completion:nil)
            
            user.removeAll()
        }
        print("current user in Login",currentUser)
        print("user in Login",user)
        print("all user in Login",allRegisteredUsers)
    }
    
    //MARK: LogOut Function
    func logoutUser(view: UIViewController) {
        
        if UserDefaults.standard.object(forKey: "users") != nil{
        allRegisteredUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
        }
        
        if UserDefaults.standard.object(forKey: "currentUser") != nil{
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
        }
        //If no one is currently logged in
        if currentUser.isEmpty == true {
            let alertController = UIAlertController(title: "Alert", message: "No one Logged in", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
        }
        
        // Complete the log out process
        else{
            
            let successAlert = UIAlertController(title:"Alert", message:"Logout SuccessFully", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
            view.navigationController?.popViewController(animated: true)
            }
            successAlert.addAction(okAction)
            view.present(successAlert, animated:true, completion:nil)

            
            user.removeAll()
            currentUser.removeAll()
        
            UserDefaults.standard.set(currentUser, forKey: "currentUser")
            UserDefaults.standard.set(allRegisteredUsers, forKey: "users")
        }
        print("current user after logout",currentUser)
        print("user after logout",user)
        print("all user after logout",allRegisteredUsers)
    }
    
    //MARK: Forget Password Function
     func forgetPassword(username: String, password: String, confirmPassword: String, securityQues: String, view: UIViewController)
        {
            if UserDefaults.standard.object(forKey: "users") != nil{
            allRegisteredUsers = UserDefaults.standard.object(forKey: "users") as! [[String]]
            }
            
            if UserDefaults.standard.object(forKey: "currentUser") != nil{
            currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String]
            }
            
            var temp : [String]?
            temp = [nil,nil,nil] as? [String]
            for i in 0...allRegisteredUsers.count-1
            {
                if username == allRegisteredUsers[i][0]
                {
                    temp = allRegisteredUsers[i]
                }
            }
            print("1\(temp ?? [""])")
            
            //Currently a user is logged in
            if  currentUser.isEmpty == false {

                let alertController = UIAlertController(title: "Already Signed in", message: "Have You forgotten your password? Kindly logout and login again to change your password.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)

                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)

            }
            
            //userName entered is wrong
             if temp == nil
            {
                let alertController = UIAlertController(title: "No Such User exists", message: "The username you have entered does not exists.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
            }
            
    //Check for password and confirmPassword password matches
            else if password != confirmPassword {
             let alertController = UIAlertController(title: "Alert", message: "Password Do not match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            view.present(alertController, animated: true, completion: nil)
            }
                
        //Answer to the security question is wrong
             else if temp?[2] != securityQues {
                let alertController = UIAlertController(title: "Wrong Answer", message: "Answer to the security question is wrong.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                view.present(alertController, animated: true, completion: nil)
             }
            
            //Change the password successfully
            else
            {
                for j in 0...allRegisteredUsers.count-1
                {
                    if username == allRegisteredUsers[j][0]
                    {
                        allRegisteredUsers[j].removeAll()
                        allRegisteredUsers[j] += [username , password , securityQues]
                    }
                }
                
                UserDefaults.standard.set(currentUser, forKey: "currentUser")
                UserDefaults.standard.set(allRegisteredUsers, forKey: "users")
                temp?.removeAll()
                currentUser.removeAll()
                allRegisteredUsers.removeAll()
                
                let myAlert = UIAlertController(title:"Alert", message:"Password Changed Succesfully", preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default){ UIAction in
                view.navigationController?.popViewController(animated: true)
                        }
                   myAlert.addAction(okAction)
                view.present(myAlert, animated:true, completion:nil)
            }
            currentUser.removeAll()
            allRegisteredUsers.removeAll()
            print("all user after password reset",allRegisteredUsers)
        }
}
