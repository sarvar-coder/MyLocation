//
//  Location+CoreDataClass.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 27/01/25.
//
//

import Foundation
import CoreLocation
import CoreData
import SwiftUI

@objc(Location)
public class Location: NSManagedObject {

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String? {
        if locationDescription.isEmpty {
            return "No Description :("
        } else {
            return locationDescription
        }
    }
    
    public var subTitle: String {
        category
    }
    
    var hasPhoto: Bool {
        photoID != nil
    }
    
    var photoURL: URL {
        assert(hasPhoto, "No photo ID set")
        let fileName = "Phot-\(photoID!.intValue).jpg"
        return applicationDocumentsDirectory.appendingPathComponent(fileName)
    }
    
    var photoImage: UIImage? {
        return UIImage(contentsOfFile: photoURL.path())
    }
    
    class func nextPhotoID() -> Int {
      let userDefaults = UserDefaults.standard
      let currentID = userDefaults.integer(forKey: "PhotoID") + 1
      userDefaults.set(currentID, forKey: "PhotoID")
      return currentID
    }
}
