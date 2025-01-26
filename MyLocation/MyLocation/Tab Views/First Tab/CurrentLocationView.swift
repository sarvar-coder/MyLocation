//
//  CurrentLocationView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 20/01/25.
//

import SwiftUI

struct CurrentLocationView: View {
    
    @StateObject var manager = LocationManager.shared
    @State private var showAlert = false
    @State private var showTagLocation = false
    
    var body: some View {
        VStack(alignment: .center) {
            messageLabel
            addresesLabel
                .padding(.leading, -70)
            addressText
            
            tagLocationButton
            Spacer()
            getMyLocationButton
                .showLocationServicesDeniedAlert(isPresented: $showAlert)
                .padding(.bottom, 60)
        }
        .fullScreenCover(isPresented: $showTagLocation) {
            NavigationStack {
                TagLocationView(coordinate: manager.location!.coordinate, placeMark: manager.placemark)
            }
        }
    }
    
    var messageLabel: some View {
        Text(manager.messageText)
            .padding(.bottom, 25)
    }
    
    @ViewBuilder
    var addresesLabel: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 30) {
                Text("Latitude:")
                Text("Longitude:")
            }
            
            .padding(.bottom)
            
            VStack(spacing: 30) {
                Text(manager.latitude)
                Text(manager.longitude)
                
            }
            .offset(x: 100, y: 0)
            .padding(.bottom)
        }
    }
    
    var addressText: some View {
        Text(manager.addressText)
            .center()
            .padding(.bottom, 50)
    }
    
    var tagLocationButton: some View {
        Button { 
            showTagLocation.toggle()
        } label: { Text("Tag Location") }
            .opacity(manager.tagButtonHidden ? 0 : 1)
    }
    
    var getMyLocationButton: some View {
        Button {
            manager.getLocation()
            showAlert = manager.showAleert
            
        } label: { Text(manager.getButtonTitle) }
    }
}

#Preview {
    CurrentLocationView()
}
