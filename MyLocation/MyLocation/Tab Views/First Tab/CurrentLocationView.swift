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
    
    var body: some View {
        VStack(alignment: .center) {
            messageLabel
            addresesLabel
        }
        .padding(.leading, -70)
        tagLocationButton
        Spacer()
        getMyLocationButton
            .showLocationServicesDeniedAlert(isPresented: $showAlert)
            .padding(.bottom, 60)
    }

    var messageLabel: some View {
        Text("Message Label")
            .padding(.bottom, 25)
    }
    
    @ViewBuilder
    var addresesLabel: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 30) {
                Text("Latitude:")
                Text("\(manager.latitude)")
            }
            .padding(.bottom)
            
            HStack(spacing: 30) {
                Text("Longitude:")
                Text("\(manager.longitude)")
            }
            .padding(.bottom)
            Text("(Addres Goes Here)")
        }
        .padding(.bottom, 50)
    }
    
    var tagLocationButton: some View {
        Button {  } label: { Text("Tag Location") }
    }
    
    var getMyLocationButton: some View {
        Button {
            manager.getLocation()
            if manager.locationError != nil {
                showAlert = true
            }
            
        } label: { Text("Get My Location") }
    }
}

#Preview {
    CurrentLocationView()
}
