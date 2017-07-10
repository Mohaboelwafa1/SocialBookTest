//
//  AddEvent.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/9/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import EventKitUI


class AddEvent: UIViewController , UITextFieldDelegate {
    
    
    
    @IBOutlet weak var outletOfTitleTxt: UITextField!
    @IBOutlet weak var outletOfNotesTxt: UITextField!
    @IBOutlet weak var outletOfFromDatePicker: UIDatePicker!
    @IBOutlet weak var outletOfToDatePicker: UIDatePicker!
    @IBOutlet weak var outletOfAddButton: UIButton!
    
    let eventStore : EKEventStore = EKEventStore()
    
    override func viewDidLoad() {
        

        self.outletOfTitleTxt.delegate = self
        self.outletOfNotesTxt.delegate = self
        
        
    }



    @IBAction func actionOfAddButton(_ sender: Any) {
        
        eventStore.requestAccess(to: .event) { (granted, error) in
            
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(error)")
                
                let event:EKEvent = EKEvent(eventStore: self.eventStore)
                
                event.title = self.outletOfTitleTxt.text!
                event.startDate = self.outletOfFromDatePicker.date
                event.endDate = self.outletOfToDatePicker.date
                event.notes = self.outletOfNotesTxt.text
                
                event.calendar = self.eventStore.defaultCalendarForNewEvents
                do {
                    try self.eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
                print("Saved Event")
                
                let alert = UIAlertController(title: "Alert", message: "Event has been added sucessfully", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK",
                                                 style: .cancel, handler: nil)
                
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
            else{
                
                print("failed to save event with error : \(error) or access not granted")
            }
        }
        
        
        
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

}
