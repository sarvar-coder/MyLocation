//
//  LocationManager.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var locationError: Error?
    var updatingLocation = true
    var isDenied = false
    
    let geoCoder = CLGeocoder()
    var placeMark: CLPlacemark?
    var perFormingReverseGeocoding = false
    var lastGecodingError: Error?
    
    override private init() {
        super.init()
        locationManager.delegate = self
    }
}
// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        self.locationError = error
        print(error.localizedDescription, "foo error")
        stopLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        self.location = newLocation
        if !perFormingReverseGeocoding {
            perFormingReverseGeocoding = true 
            self.reverseGeoCoding(with: newLocation)
        }
        
        self.locationError = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .notDetermined:
            isDenied = false
        case .restricted, .denied:
            isDenied = true
        case .authorizedAlways, .authorizedWhenInUse:
            isDenied = false
            startLocation()
        @unknown default:
            print("Unkown")
        }
    }
}
// MARK: - Helper methods
extension LocationManager {
    
    func askPermission() {
        let authStatus = locationManager.authorizationStatus
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if updatingLocation {
            stopLocation()
        } else {
            locationError = nil
            location = nil
            placeMark = nil
            lastGecodingError = nil 
            startLocation()
        }
    }
    
    func startLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
    
    func stopLocation() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    func reverseGeoCoding(with location: CLLocation) {
        
        geoCoder.reverseGeocodeLocation(location) { placeMarks, error in
            
            self.lastGecodingError = error
            
            if error == nil, let places = placeMarks, !places.isEmpty {
                self.placeMark = places.last!
            } else {
                self.placeMark = nil
            }
            
            self.perFormingReverseGeocoding = false
        }
    }
}
