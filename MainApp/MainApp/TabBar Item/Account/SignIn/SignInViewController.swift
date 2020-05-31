//
//  SignInVC.swift
//  MainApp
//
//  Created by Anmol Chauhan on 24/04/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class SignInViewController: UIViewController , GIDSignInDelegate{


    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fbLoginbutton: FBLoginButton!
    
    var login = ManualLogin()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginbutton.delegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentuser()
    }

    //manual login button
    @IBAction func manualLoginBtnTapped(_ sender: Any){
    
        login.loginUSer(username: userNameTextField.text ?? "", Password: passwordTextField.text ?? "", view: self)

    }
    
    //action for google login
    @IBAction func googleSignInTapped(_ sender: GIDSignInButton) {
        
        if Auth.auth().currentUser != nil {
        let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
        }
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            print("Google Sing In")
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: (authentication.idToken)!, accessToken: (authentication.accessToken)!)
        // When user is signed in
            if Auth.auth().currentUser != nil {
                let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert);
                
                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
                //print(self.currentuser())
            }
            
            else {
            Auth.auth().signIn(with: credential, completion: { (user, error) in
              if let error = error {
                print("Login error: \(error.localizedDescription)")
                return
              }
                if error != nil {
                    return
                }
                else {
                    let myAlert = UIAlertController(title:"Alert", message:"User successfully SignIn", preferredStyle: UIAlertController.Style.alert);
                    
                    let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                    
                    myAlert.addAction(okAction);
                    self.present(myAlert, animated:true, completion:nil);
                    self.currentuser()
                    print(self.currentuser())
                }
            })
                
            }

    }
    
    
    func currentuser() {
        if let currentUser = Auth.auth().currentUser {
        UserDefaults.standard.set(true, forKey: "LoggedIn")
            UserDefaults.standard.synchronize()
            print(currentUser)
        }
    }
    
    
   
   //action for logout button
    @IBAction func logoutBtnTapped(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance().signOut()
        try! Auth.auth().signOut()
        login.logoutUser(view: self)

    }
    
    //action for forget password
    @IBAction func forgotPasswordBtnTapped(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

//extension for facebook login
extension SignInViewController : LoginButtonDelegate{
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
          print(error.localizedDescription)
          return
        }
        else {
             if Auth.auth().currentUser != nil {
                let myAlert = UIAlertController(title:"Alert", message:"Already SignIn", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil);
                       
                myAlert.addAction(okAction);
                self.present(myAlert, animated:true, completion:nil);
             }
             else {
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        return
                    }
                    if error != nil {
                    return
                    }
                    else {
                        let myAlert = UIAlertController(title:"Alert", message:"User successfully SignIn", preferredStyle: UIAlertController.Style.alert)
                        let okAction = UIAlertAction(title:"Ok", style:UIAlertAction.Style.default, handler:nil)
                        myAlert.addAction(okAction);
                        self.present(myAlert, animated:true, completion:nil);
                        self.currentuser()
                    }
                })
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("UserLoggedOut")
        LoginManager().logOut()
        try! Auth.auth().signOut()
        print("successfully logout from facebok")
    }
}
