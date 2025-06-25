//
//  Persistence.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for I in 1...10 {
            
            let location = Location(context: viewContext)
            
            location.id = UUID().uuidString
            
            location.date = Date()
            location.desript = "full of lovely books here"
            location.latitude = 12.123456
            location.latitude = -12.123456
            location.placemark = nil
            if I % 2 == 0 {
                location.category = "BookStore"
            } else {
                location.category = "Club"
            }
        }
        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \((error as NSError).userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

   private init(inMemory: Bool = false) {
        
        ValueTransformer.setValueTransformer(PlaceMarkTransFormer(), forName: NSValueTransformerName(rawValue: "Placemark"))
        
        container = NSPersistentContainer(name: "MyLocations")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
