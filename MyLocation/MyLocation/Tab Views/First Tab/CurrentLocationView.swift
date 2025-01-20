//
//  CurrentLocationView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 20/01/25.
//

import SwiftUI

struct CurrentLocationView: View {
    var body: some View {
        VStack() {
            
            Text("Message Label")
                .padding(.bottom, 25)
            
            VStack(alignment: .leading) {
                
                HStack(spacing: 30) {
                    Text("Latitude:");  Text("(Latitude goes here)")
                }
                .padding(.bottom)
                
                HStack(spacing: 30) {
                    Text("Longitude:");  Text("(Longitude goes here)")
                }
                .padding(.bottom)
                
                Text("(Addres Goes Here)")
            }
            .padding(.bottom, 50)
            
        }
        .padding(.leading, -70)
        
        Button {  } label: { Text("Tag Location") }
        
        Spacer()
        
        Button {  } label: { Text("Get My Location") }
            .padding(.bottom, 60)
        
    }
}

#Preview {
    CurrentLocationView()
}
