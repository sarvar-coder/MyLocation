//
//  LocationsView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 04/02/25.
//

import SwiftUI

struct LocationsView: View {
    
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    @Environment(\.managedObjectContext) private var context
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(locations) { location in
                        
                        LocationsCellView(location: location)
                        
                    }
                    .onDelete(perform: deleteLocation)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Location")
        .toolbarTitleDisplayMode(.inline)
    }
    
    private func deleteLocation(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let selectedLocation = locations[index]
            context.delete(selectedLocation)
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LocationsView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
