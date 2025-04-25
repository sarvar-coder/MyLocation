//
//  LocationListView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 13/04/25.
//

import SwiftUI

struct LocationListView: View {
    
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    @Environment(\.managedObjectContext) private var viewContext
      
    var body: some View {
        NavigationStack {
            VStack {
                List() {
                    ForEach(locations) { location in
                        NavigationLink {
                            TagLocationView(coordinate: location.coordinate, location: location, updateLocation: updateLocation)
                        } label: {
                            LocationCellView(location: location)
                                .padding(.bottom)
                        }

                        
                    }
                    .onDelete{ indexSet in
                        delete(indexSet: indexSet)
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.never, axes: .vertical)
            }
            .toolbar {
                EditButton()
            }
        }
        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func updateLocation(location: Location) {
        do {
            try viewContext.save()
        } catch {
            debugPrint(error.localizedDescription, "foo")
        }
    }
    
    func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            let location = locations[index]
            location.removePhotoFile()
            viewContext.delete(location)
            do {
                try viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
      
            location.photoID = nil
        }
    }
}

#Preview {
    NavigationStack {
        LocationListView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}


