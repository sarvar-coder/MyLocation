//
//  CurrentLocationView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI

struct CurrentLocationView: View {
    
    @StateObject var viewModel = CurrentLocationViewModel.shared
    @State private var showTagLocationView = false

    var body: some View {
        VStack(alignment: .leading) {
            
            LocationBlockView(message: viewModel.messageLabel,
                              latatitude: viewModel.latatitude,
                              longitude: viewModel.longitude,
                              addressText: viewModel.addressText)
            
            if !viewModel.tagButtonIsHidden {
                tagLocationButton
            }
            Spacer()
            getMyLocationButton
        }
        .padding()
        
        .fullScreenCover(isPresented: $showTagLocationView, content: {
            NavigationStack {
                TagLocationView(coordinate: Coordinate(latitude: viewModel.latatitude, longitude: viewModel.longitude),
                                placeMark: viewModel.locationManager.placeMark
                                ) {_ in}
            }
        })
    }
    
    var tagLocationButton: some View {
        
        Button {
            showTagLocationView.toggle()
        } label: {
            Text("Tag Location")
        }
        
        .centerView()
        
    }
    
    var getMyLocationButton: some View {
        Button {
            viewModel.getLocation()
        } label: {
            Text(viewModel.getButtontitle)
        }
        .centerView()
        .padding([.bottom], 16)
    }
}

#Preview {
    CurrentLocationView()
}
