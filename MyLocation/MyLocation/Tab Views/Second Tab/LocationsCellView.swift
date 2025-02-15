//
//  LocationsCell.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 04/02/25.
//

import SwiftUI

struct LocationsCellView: View {
    
    let location: Location
    
    var body: some View {
        HStack(spacing: 20) {
            if let image = location.photoImage, location.hasPhoto {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 52, height: 52)
            } else {
                Image(systemName: "photo.artframe")
                    .resizable()
                    .frame(width: 52, height: 52)
            }
            VStack(alignment:.leading, spacing: 8) {
                Text(configureDescription(location))
                    .bold()
                    .font(.system(size: 18))
                    .foregroundStyle(.primary)
                Spacer()
                HStack {
                    if let placemark = location.placemark {
                        Text(stringPlacemark(placemark))
                            .foregroundStyle(.secondary)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    Text(location.category)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
    }
}
