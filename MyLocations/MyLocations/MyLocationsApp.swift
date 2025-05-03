//
//  MyLocationsApp.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI

let tintColor = Color(red: 255/255.0, green: 238/255.0, blue: 136/255.0)

@main
struct MyLocationsApp: App {
    
    init() {
        let tintColor = UIColor(red: 255/255.0, green: 238/255.0, blue: 136/255.0, alpha: 1)
        
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().unselectedItemTintColor = .gray
    }
    
    let persistentController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.viewContext)
                .onAppear { print(applicationDocumentsDirectory)}
                .environment(\.colorScheme, .dark)
        }
    }
}
