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
    @Published var updatingLocation = false
    @Published var location: CLLocation?
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var tagButtonHidden = true
    @Published var messageText = ""
    @Published var addressText = ""
    @Published var getButtonTitle = "Get My Location"
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.askPermission()
    }
    
    
    func getLocation() {
        if updatingLocation {
            stopLocationManager()
        } else {
            startLocationManager()
            locationError = nil
            updateLabels()
        }
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
        
        print("didFailWithError: \(String(describing: locationError))")
        
        if (error as NSError).code == CLError.locationUnknown.rawValue { return }
        locationError = error
        //         stopLocationManager()
        updateLabels()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let  newLocation = locations.last else { return }
        location = newLocation
        
        if newLocation.timestamp.timeIntervalSinceNow < -5 { return }
         
        
        if newLocation.horizontalAccuracy < 0 { return }
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            locationError = nil
            location = newLocation
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done")
                stopLocationManager()
            }
            updateLabels()
        }
    }
    
    private func updateLabels() {
        if let location {
            
            latitude = String(format: "%.8f", location.coordinate.latitude)
            longitude = String(format: "%.8f", location.coordinate.longitude)
            tagButtonHidden = false
            messageText = ""
            
        } else {
            
            latitude = ""
            longitude = ""
            tagButtonHidden = true
            addressText = ""
            
            let statusMessage: String
            
            if let error = locationError as NSError? {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "Location Services Disabled"
                } else {
                    statusMessage = "Error Getting Location"
                }
                
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            } else if updatingLocation {
                statusMessage = "Searching..."
            } else {
                statusMessage = "Tap 'Get My Location' to Start"
            }
            messageText = statusMessage
        }
//        configureGetButton()
    }
    
    private func configureGetButton() {
        if updatingLocation {
            getButtonTitle = "Stop"
        } else {
            getButtonTitle = "Get My Location"
        }
    }
    
    private func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    private func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
        }
    }
}
