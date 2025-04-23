//
//  MyLocationsApp.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI

@main
struct MyLocationsApp: App {
    
    let persistentController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.viewContext)
                .onAppear { print(documentsDirectory)}
        } 
    }
}

var documentsDirectory: URL {
    URL.documentsDirectory
}
