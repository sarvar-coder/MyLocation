//
//  MapView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 06/02/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    
    var body: some View {
        NavigationStack {
            Map {
                ForEach(locations) { location in
                    Annotation(location.title ?? "", coordinate: location.coordinate) {
                        Image(systemName: "mappin.square.fill")
                            .imageScale(.large)
                            .foregroundStyle(.indigo)
                    }
                }
                
            }
        }
    }
}

#Preview {
    MapView()
        .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
}
