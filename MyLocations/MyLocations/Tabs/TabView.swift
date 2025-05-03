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
            Group {
                CurrentLocationView().tabItem {
                    HStack {
                        Image(ImagesManager.tag)
                            .renderingMode(.template)
                            .tint(tintColor)
                        Text("Tag")
                            .foregroundStyle(tintColor)
                    }
                }.tag(0)
                NavigationStack {
                    LocationListView()
                }
                .tabItem {
                    HStack {
                        Image(ImagesManager.locations)
                            .renderingMode(.template)
                            .tint(tintColor)
                        Text("Locations")
                            .foregroundStyle(tintColor)
                    }
                    
                }.tag(1)
                
                LocationMapView()
                    .tabItem {
                        HStack {
                            Image(ImagesManager.map)
                                .renderingMode(.template)
                                .tint(tintColor)
                            Text("Map")
                                .foregroundStyle(tintColor)
                        }
                    }.tag(2)
            }
        }
    }
}

#Preview {
    TabViews()
}
