//
//  MapView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let xorazm = CLLocationCoordinate2D(latitude: 41.2996, longitude: 61.0884)
}

struct LocationMapView: View {
    
    
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    @State private var mapStyle: MapStyle = .imagery
    @State var position: MapCameraPosition = .userLocation(fallback: .automatic)
//    @State private var position = Positi
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Map(position: $position) {
                    ForEach(locations) { location in
                        Annotation(location.title,
                                   coordinate: location.annotationCoordinate,
                                   anchor: .center) {
                            Image(systemName: "mappin.and.ellipse")
                                .padding(4)
                                .foregroundStyle(.white)
                                .background(.red)
                                .cornerRadius(5)
                        }
                    }
                    
                    UserAnnotation()
                }
                .mapStyle(mapStyle)
            }
            .navigationTitle("Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        position = .automatic
                    } label: {
                        Image(ImagesManager.locations)
                            .renderingMode(.template)
                            .tint(tintColor)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        position = .userLocation(fallback: .automatic)
                    } label: {
                        Image(ImagesManager.user)
                            .renderingMode(.template)
                            .tint(tintColor)
                    }
                }
            }
        }
    }
}

#Preview {
    LocationMapView()
}
