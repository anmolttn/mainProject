//
//  FacebookLoginViewController.swift
//  MainApp
//
//  Created by Anmol Chauhan on 04/05/20.
//  Copyright © 2020 Anmol Chauhan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class FacebookLoginViewController: UIViewController , LoginButtonDelegate{
   

    @IBOutlet weak var fbLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = FBLoginButton()
        
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 20, y: 150, width: view.frame.width - 32, height: 50)
        // Do any additional setup after loading the view.
        loginButton.delegate = self
        loginButton.permissions = ["email"]
    }
    
    @IBAction func btnFbLogin(_ sender: Any) {
        
        print("cutom login button tapped")
        LoginManager().logIn(permissions: ["email"], from: self) { (result, error) in
            if error != nil{
                print("custom fb login failed")
                return
            }
            //print(result?.token?.tokenString)
            self.showEmail()
            
        }
        
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
         if error != nil{
            print(error ?? "")
            return
        }
        else{
            print("successfully login with facebook")
        }
        showEmail()
       }
       
       func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
           print("successfully logout from facebok")
       }
    
    func showEmail(){
        
        let accessToken = AccessToken.current
        guard let accessTokenString = accessToken?.tokenString else {
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil{
                print("something went wrong with our user ", error)
                return
            }
            print("successfully logged in with our user ", user)
        }
        
        GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil{
                print("error in graph request.", err)
                return
            }
            print(result)
        }
        
    }
       
    
    
}
