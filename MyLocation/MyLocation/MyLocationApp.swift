//
//  MyLocationApp.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 20/01/25.
//

import SwiftUI

@main
struct MyLocationApp: App {
    
    let persistentContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MyLocationTabView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
                .onAppear {
                    print(applicationDocumentsDirectory.path())
                }
        }
    
    }
}

