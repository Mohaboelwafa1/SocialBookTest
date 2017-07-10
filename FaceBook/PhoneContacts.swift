//
//  PhoneContacts.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/9/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import Contacts
import ContactsUI

class PhoneContacts : UIViewController , CNContactPickerDelegate {
    
    // access user contacts
    @available(iOS 9.0, *)
    lazy var store = CNContactStore();
    
    override func viewDidLoad() {
        // --
        
        if #available(iOS 9.0, *) {
            switch CNContactStore.authorizationStatus(for: .contacts){
            case .authorized:
                showContact()
            case .notDetermined:
                store.requestAccess(for: .contacts){succeeded, err in
                    guard err == nil && succeeded else{
                        return
                    }
                    
                }
            default:
                print("Not handled")
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    func showContact() {
        

        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
        
        
    }
    
    
    //MARK:- CNContactPickerDelegate Method
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        contacts.forEach { contact in
            for number in contact.phoneNumbers {
                let phoneNumber = number.value
                print("number is = \(phoneNumber)")
            }
        }
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    
    
   
}
