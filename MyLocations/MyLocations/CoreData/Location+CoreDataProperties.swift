//
//  Location+CoreDataProperties.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 13/04/25.
//
//

import Foundation
import CoreData
import CoreLocation


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var desript: String
    @NSManaged public var category: String
    @NSManaged public var longitude: Double
    @NSManaged public var date: Date
    @NSManaged public var placemark: CLPlacemark?
    @NSManaged public var id: String
    @NSManaged public var photoID: NSNumber?

}

extension Location : Identifiable {

}
