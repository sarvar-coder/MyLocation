//
//  PlaceMarkTransFormer.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 13/04/25.
//

import Foundation
import CoreLocation

class PlaceMarkTransFormer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let placemark = value as? CLPlacemark else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: placemark, requiringSecureCoding: true)
            return data
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let placemark = try NSKeyedUnarchiver.unarchivedObject(ofClass: CLPlacemark.self, from: data)
            return placemark
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
