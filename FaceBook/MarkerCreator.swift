//
//  MarkerCreator.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/10/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps


class MarkerCreator {
    
    class func returnMarkerData(coor : CLLocationCoordinate2D , title : String , sentiment : String) -> GMSMarker {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coor.latitude, longitude: coor.longitude)
        marker.title = title
        marker.snippet = sentiment
        
        
        if sentiment.contains("Dealer") {  // Dealer
            marker.icon = GMSMarker.markerImage(with: .blue)
        }
        else if sentiment.contains("Shop") { // Shop
            
            marker.icon = GMSMarker.markerImage(with: .red)
        }
        else if sentiment.contains("ATM") { // ATM
            
            marker.icon = GMSMarker.markerImage(with: .green)
        }
        
        else {  // Bank
            
            marker.icon = GMSMarker.markerImage(with: .black)
        }
        
        return marker
    }
}
