//
//  LocationCellView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 13/04/25.
//

import SwiftUI

struct LocationCellView: View {
    @ObservedObject var location: Location
    var body: some View {
        HStack() {
            if let photo = location.photoImage {
                Image(uiImage: photo)
                    .resizable()
                    .frame(width: 48, height: 48)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
                    
            } else {
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
                    
            }
            VStack(alignment: .leading, spacing: 12) {
                Text(configureDescription(location: location))
                    .bold()
                    .font(.system(size: 21))
                Text(configureAddress(location: location))
                    .foregroundStyle(.secondary)
                    .font(.system(size: 17))
            }
            Spacer()
        }
    }
}
