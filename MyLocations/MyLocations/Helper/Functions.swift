//
//  Functions.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 08/04/25.
//

import CoreLocation

func string(from placemark: CLPlacemark) -> String {
    
    var line1 = ""
    
    if let tmp = placemark.subThoroughfare {
        line1 += tmp + " "
    }
    
    if let tmp = placemark.thoroughfare {
        line1 += tmp }
    
    var line2 = ""
    
    if let tmp = placemark.locality {
        line2 += tmp + " "
    }
    
    if let tmp = placemark.administrativeArea {
        line2 += tmp + " "
    }
    
    if let tmp = placemark.postalCode {
        line2 += tmp }
    
    return line1 + "\n" + line2
}

func configureDescription(location: Location) -> String {
    if !location.desript.isEmpty {
        return location.desript
    } else {
        return "(No Description)"
    }
}

func configureAddress(location: Location?) -> String {
    var text = ""
    
    guard let location = location else { return text }
    
    text = String(format: "Lat: %.4f, Long: %.4f", location.latitude, location.longitude)
    
    guard let placemark = location.placemark else { return text }
    
    if let tmp = placemark.subThoroughfare {
        text += tmp
    }
    
    if let tmp = placemark.thoroughfare {
        text += ", " + tmp
    }
    
    if let tmp = placemark.locality {
        text += ", " + tmp
    }
    
    return text
}

let applicationDocumentsDirectory: URL = {
  let paths = FileManager.default.urls(
    for: .documentDirectory,
       in: .userDomainMask)
  return paths[0]
}()

