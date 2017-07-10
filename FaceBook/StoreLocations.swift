//
//  StoreLocations.swift
//  FaceBook
//
//  Created by mohamed hassan on 7/10/17.
//  Copyright © 2017 mohamed hassan. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import GooglePlaces


class StoreLocations: UIViewController , CLLocationManagerDelegate {

    
    // location manager related vars
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 7.0
    var listOfLocation : [MarkerModel] = [MarkerModel]()
    var listOfMarkers : [GMSMarker] = [GMSMarker]()
    
    override func viewDidLoad() {
        // ---
        
        print("Example of dummy data")
        let bankEX = MarkerModel()
        bankEX.title = "HSBC"
        bankEX.sentiment = "Bank"
        bankEX.coor = CLLocationCoordinate2D(latitude: 31.00, longitude: 30.11)
        
        let ATMEX = MarkerModel()
        ATMEX.title = "ALHLI ATM"
        ATMEX.sentiment = "ATM"
        ATMEX.coor = CLLocationCoordinate2D(latitude: 31.11, longitude: 30.123)
        
        let shopEX = MarkerModel()
        shopEX.title = "Adidas"
        shopEX.sentiment = "Shop"
        shopEX.coor = CLLocationCoordinate2D(latitude: 32.00, longitude: 30.11)
        
        let dealerEX = MarkerModel()
        dealerEX.title = "Test"
        dealerEX.sentiment = "Dealer"
        dealerEX.coor = CLLocationCoordinate2D(latitude: 31.33, longitude: 30.11)
        
        
        
        listOfLocation.append(bankEX)
        listOfLocation.append(ATMEX)
        listOfLocation.append(shopEX)
        listOfLocation.append(dealerEX)
        
        // configuration of location manager
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        
        // ----- Draw the map on the screen
        
        let camera = GMSCameraPosition.camera(withLatitude: 30.0,longitude: 30.0,zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Add the map to the view, hide it until we've got a location update.
        view.addSubview(mapView)
        
        // Move the camera to current user location
        self.getCurrentAddress()
        
        
        
        // adding markers
        addMarkers()
        
    }
    
    
    func addMarkers() {
        
        for index in 0...self.listOfLocation.count-1 {
            self.listOfMarkers.append(MarkerCreator.returnMarkerData(coor: listOfLocation[index].coor, title: listOfLocation[index].title, sentiment: listOfLocation[index].sentiment))
            
            self.listOfMarkers[index].map = mapView
            
        }
    }
    
    
    // Get current address by google places api
    func getCurrentAddress () {
        
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
        })
    }
    
    
    
    // Location manager delegate functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
        
        
    }
    
    
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }

    
    
    
    
    
    
}



