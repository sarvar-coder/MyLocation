//
//  TabView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI

struct TabViews: View {
    @State private var selectedTab = 0
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            CurrentLocationView().tabItem { Text("Current") }.tag(0)
            NavigationStack {
                LocationListView()
            }
            .tabItem { Text("Locations")}.tag(1)
            
            LocationMapView()
                .tabItem { Text("Map") }.tag(2)
        }
    }
}

#Preview {
    TabViews()
}
