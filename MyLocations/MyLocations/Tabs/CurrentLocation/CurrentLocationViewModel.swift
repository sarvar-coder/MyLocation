//
//  CurrentLocationViewModel.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import Foundation
import CoreLocation
import SwiftUI

class CurrentLocationViewModel: ObservableObject {
    
    static let shared = CurrentLocationViewModel()
    @Published var locationManager = LocationManager.shared
    
    @Published var latatitude = ""
    @Published var longitude = ""
    @Published var tagButtonIsHidden = true
    @Published var messageLabel = ""
    @Published var getButtontitle = "Get My Location"
    @Published var addressText = ""
    
    private init() {}
    
    func getLocation() {
        locationManager.askPermission()
        
        updateLabel()
    }
    
    func updateLabel() {
        if let location = locationManager.location {
            withAnimation(.easeInOut(duration: 0.3)) {
                latatitude = String(format: "%.8f", location.coordinate.latitude)
                longitude = String(format: "%.8f", location.coordinate.longitude)
                tagButtonIsHidden = false
                messageLabel = ""
                displayAddress()
            }
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                latatitude = ""
                longitude = ""
                tagButtonIsHidden = true
                messageLabel = "Tap 'Get My Location' Button to Start"
                addressText = ""
            }
        }
        configureButtonTitle()
    }
    
    func configureButtonTitle() {
        withAnimation(.bouncy(duration: 0.3)) {
            if !locationManager.updatingLocation {
                getButtontitle = "Stop"
            } else {
                getButtontitle = "Get My Location"
            }
        }
    }
    
    func displayAddress() {
        if let address = locationManager.placeMark {
            self.addressText = string(from: address)
        } else if locationManager.updatingLocation {
            self.addressText = "Searching For address"
        } else if  locationManager.lastGecodingError != nil {
            self.addressText = "Error While Searching Address"
        } else {
            self.addressText = "No Address Found"
        }
    }
}
