//
//  MyLocationTabView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 04/02/25.
//

import Foundation
import SwiftUI

struct MyLocationTabView: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab ) {
            CurrentLocationView()
                .tabItem { Text("Tag") }
            NavigationStack {
                LocationsView()
            }
                .tabItem { Text("Locations") }
            
            MapView()
                .tabItem { Text("Map") }
        }
    }
}

#Preview {
    MyLocationTabView()
}
