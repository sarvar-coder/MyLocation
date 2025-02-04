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
    
    @Published var showAleert = false
    @Published var locationError: Error? = nil
    @Published var updatingLocation = false
    @Published var location: CLLocation?
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var tagButtonHidden = true
    @Published var messageText = ""
    @Published var addressText = ""
    @Published var getButtonTitle = "Get My Location"
    
    // Reverse geocoding
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeoCodingError: Error?
    var timer: Timer?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
    }
    
    //    MARK: - Actions
    func getLocation() {
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showAleert = true
            return
        }
        placemark = nil
        lastGeoCodingError = nil
        startLocationManager()
        locationError = nil
        updateLabels()
    }
    
    private func askPermission() {
        let authStatus = locationManager.authorizationStatus
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
    }
    
    @objc func didTimeOut() {
        if location == nil {
            stopLocationManager()
            locationError = NSError(
              domain: "MyLocationsErrorDomain",
              code: 1,
              userInfo: nil)
            updateLabels()
          }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("didFailWithError: \(String(describing: locationError))")
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        locationError = error
        stopLocationManager()
        updateLabels()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let  newLocation = locations.last else { return }
        location = newLocation
        
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
    
         var distance =
       CLLocationDistance(Double.greatestFiniteMagnitude)
         if let location = location {
           distance = newLocation.distance(from: location)
         }
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            locationError = nil
            location = newLocation
            
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We'are done")
                stopLocationManager()
                
                if distance > 0 {
                    performingReverseGeocoding = false
                }
            }
        }
//        updateLabels()
        reverseGeoCoding(newLocation: newLocation, distance: distance)
    }
    //     MARK: - Helper Methods
    private func updateLabels() {
        if let location {
            
            latitude = String(format: "%.8f", location.coordinate.latitude)
            longitude = String(format: "%.8f", location.coordinate.longitude)
            tagButtonHidden = false
            messageText = ""
            displayAddress()
            
        } else {
            
            latitude = ""
            longitude = ""
            tagButtonHidden = true
            addressText = ""
            
            showErrorMessage()
        }
    }
    
    func showErrorMessage()  {
        
        let statusMessage: String
        if let error = self.locationError as NSError? {
            if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                statusMessage = "Location Services Disabled"
            } else {
                statusMessage = "Error Getting Location"
            }
        } else if !CLLocationManager.locationServicesEnabled() {
            statusMessage = "Location Services Disabled"
        } else if self.updatingLocation {
            statusMessage = "Searching..."
        } else {
            statusMessage = "Tap 'Get My Location' to Start"
        }
        self.messageText = statusMessage
    }
    
    func displayAddress() {
        if let placemark {
            addressText = string(from: placemark)
        } else if performingReverseGeocoding {
            addressText = "Searching For Address"
        } else if lastGeoCodingError != nil {
            addressText = "Error Getting Address"
        } else {
            addressText = "No Address Found"
        }
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
            
            if let timer {
                timer.invalidate()
            }
        }
    }
    
    private func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
            self.updatingLocation = true
            
            timer = Timer.scheduledTimer(
                timeInterval: 60,
                target: self,
                selector: #selector(didTimeOut),
                userInfo: nil,
                repeats: false)
        }
    }
    
    private func reverseGeoCoding(newLocation: CLLocation, distance: CLLocationDistance) {
        if !performingReverseGeocoding {
            print("*** Going to geocode")
            
            performingReverseGeocoding = true
            
            geocoder.reverseGeocodeLocation(newLocation) { placemarks, error in
                self.lastGeoCodingError = error
                if error == nil, let places = placemarks, !places.isEmpty {
                    self.placemark = places.last
                } else {
                    self.placemark = nil
                }
                
                self.performingReverseGeocoding = false
                self.updateLabels()
            }
            updateLabels()
        } else if distance < 1 {
            let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
            if timeInterval > 10 {
                print("*** Force done!")
                stopLocationManager()
                updateLabels()
            }
        }
    }
}
