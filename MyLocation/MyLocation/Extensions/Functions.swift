//
//  Functions.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 04/02/25.
//

import Foundation
import CoreLocation

public func string(from placemark: CLPlacemark) -> String {
    // 1
    var line1 = ""
    // 2
    if let tmp = placemark.subThoroughfare {
        line1 += tmp + " "
    }
    // 3
    if let tmp = placemark.thoroughfare {
        line1 += tmp }
    // 4
    var line2 = ""
    if let tmp = placemark.locality {
        line2 += tmp + " "
    }
    if let tmp = placemark.administrativeArea {
        line2 += tmp + " "
    }
    if let tmp = placemark.postalCode {
        line2 += tmp }
    // 5
    return line1 + line2
}
