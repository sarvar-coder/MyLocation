//
//  Persistence.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 28/01/25.
//

import Foundation
import CoreData
import CoreLocation

class PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    static var preview: PersistenceController = {
        
        let container = PersistenceController(inMemory: true)
        let context = container.viewContext
        
        let location = Location(context: context)
        location.category = "Apple"
        location.date = Date()
        location.latitude = 37.3346438
        location.longitude = -122.1531676
        location.locationDescription = "This main apple campus my job"
        
        let location1 = Location(context: context)
        location1.category = "Store"
        location1.date = Date()
        location1.latitude = 37.3346438
        location1.longitude = -122.1531676
        location1.locationDescription = "This main apple campus my job"
        
        let location2 = Location(context: context)
        location2.category = "Apple"
        location2.date = Date()
        location2.latitude = 37.3346438
        location2.longitude = -122.1531676
        location2.locationDescription = "This main apple campus my job"
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        return container
    }()
    
    init(inMemory: Bool = false) {
        self.container = NSPersistentContainer(name: "MyLocations")
        
        if inMemory {
            container.persistentStoreDescriptions.last!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
