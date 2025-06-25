//
//  Location+CoreDataClass.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 13/04/25.
//
//

import Foundation
import CoreData
import CoreLocation
import UIKit

@objc(Location)
public class Location: NSManagedObject {

    var coordinate: Coordinate {
        Coordinate(latitude: String(latitude), longitude: String(longitude))
    }
    
    public var annotationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String {
        if desript.isEmpty {
            return "(No Description)"
        } else {
            return desript
        }
    }
    
    public var subTitle: String {
        return category
    }
    
    public var hasPhoto: Bool {
        photoID != nil
    }
    
    public var photoURL: URL {
//        assert(photoID != nil, "crash")
        let fileName = "Photo\(photoID?.intValue).jpg"
        return applicationDocumentsDirectory.appendingPathComponent(fileName)
    }
    
    var photoImage: UIImage? {
        return UIImage(contentsOfFile: photoURL.path)
    }
    
    class func nextPhotoID() -> Int {
        let userDefaults = UserDefaults.standard
        let currentID = userDefaults.integer(forKey: "id") + 1
        userDefaults.set(currentID, forKey: "id")
        return currentID
    }
    
    func removePhotoFile() {
      if hasPhoto {
        do {
          try FileManager.default.removeItem(at: photoURL)
        } catch {
          print("Error removing file: \(error)")
        }
      }
    }
}
