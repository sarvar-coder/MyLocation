//
//  LocationBlockView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 07/04/25.
//

import Foundation
import SwiftUI

struct LocationBlockView: View {
    
    let message: String
    let latatitude: String
    let longitude: String
    let addressText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(message)
                .centerView()
                .padding(.bottom)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Latitude:    ")
                    Spacer()
                    Text(latatitude)
                }
                HStack {
                    Text("Longitude:  ")
                    Spacer()
                    Text(longitude)
                }
                
                Text(addressText)
            }
            .padding([.bottom], 60)
        }
    }
}
