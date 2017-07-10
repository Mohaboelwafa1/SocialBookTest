//
//  FaceBookFriends.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/9/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit

import FacebookLogin
import FBSDKCoreKit

import FacebookShare
import FacebookCore
import FBSDKLoginKit

class FaceBookFriends : UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var otletOfTableView: UITableView!
    
    var listOfFriends : [FriendProfileModel] = [FriendProfileModel]()
    override func viewDidLoad() {
        
        
        
        // check if user login or logout
        if FBSDKAccessToken.current() != nil {
            // User is logged in, use 'accessToken' here.
            print("User is logged in, use 'accessToken' here.")
            
            fetchProfile()
            
        } else {
            print("user is not logged in")
        }
        
        
        
    }
    
    func fetchProfile() {
        let parameters = ["fields": "email, first_name, last_name, picture.type(large) , name , friendlists , friends"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, user, requestError) -> Void in
            
            if requestError != nil {
                print(requestError!)
                return
            }
            
            print("user user user :::")

            
            let data    = user as! NSDictionary
            let friends = data ["friends"] as! NSDictionary
        
            let friendsData = friends["data"] as! NSArray

            print(friendsData)
            
            for index in 0...friendsData.count - 1 {
               
                let friendProfile = friendsData[index] as! NSDictionary
                
                let row = FriendProfileModel()
                
                row.id = friendProfile["id"] as! String
                row.name = friendProfile["name"] as! String
                
                
                
                self.listOfFriends.append(row)
            }
            
            self.otletOfTableView.reloadData()
            
            
            
        })
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ElementCell")
        
        
        // asign the data to the labels
        cell.textLabel?.text = listOfFriends[indexPath.row].name
        cell.accessoryType = .disclosureIndicator                                 // -> the arrow in the cell
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ---
    }
}
