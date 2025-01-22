//
//  LocationManager.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 20/01/25.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    static let shared = LocationManager()
    let locationManager: CLLocationManager
    
    @Published var locationError: Error? = nil
    @Published var location: CLLocation?
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var tagButtonHidden = true
    @Published var messageText = ""
    @Published var addressText = ""
    
   override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.askPermission()
    }
    
    
    func getLocation() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    private func askPermission() {
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         locationError = error
         print("didFailWithError: \(String(describing: locationError))")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let  newLocation = locations.last else { return }
        location = newLocation
        updateLabels()
    }
    
    func updateLabels() {
        if let location {
            latitude = String(format: "%.8f", location.coordinate.latitude)
            
            longitude = String(format: "%.8f", location.coordinate.longitude)
            
            tagButtonHidden = false
            
            messageText = ""
        } else {
            latitude = ""
            longitude = ""
            messageText = "Tap 'Get My Location' to Start"
            tagButtonHidden = true
            addressText = ""
        }
    }
}
