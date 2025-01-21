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
    @Published var latitude: CLLocationDegrees = 0.0
    @Published var longitude: CLLocationDegrees = 0.0
    
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
        latitude = newLocation.coordinate.latitude
        longitude = newLocation.coordinate.longitude
    }
    
}
