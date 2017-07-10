//
//  ViewController.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/7/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit

import FacebookShare
import FacebookCore
import FBSDKLoginKit

class logInViewController: UIViewController , FBSDKLoginButtonDelegate {

    
    
    // oulets
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    @IBOutlet weak var rememberMeLabel: UILabel!
    @IBOutlet weak var tasksButton: UIButton!
    
    var nav : UINavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // adding login button
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email , .userFriends ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        
        // check if user login or logout
        if FBSDKAccessToken.current() != nil {
            // User is logged in, use 'accessToken' here.
            print("User is logged in, use 'accessToken' here.")

        } else {
            print("User is not logged in")
            
        }
        

    
        
    }
    
    
   
    
    @IBAction func goToListOfTasks(_ sender: Any) {
    }
    

    
    

    

    // login button delegate functions
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
     
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
       
    }
    
    public func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {

        return true
    }
    
    

}

