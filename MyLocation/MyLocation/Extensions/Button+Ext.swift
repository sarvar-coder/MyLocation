//
//  Button+Ext.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 21/01/25.
//

import Foundation
import SwiftUI

extension View {
    func showLocationServicesDeniedAlert(isPresented: Binding<Bool>) -> some View {
        alert("Location Service disabled", isPresented: isPresented) {
            Button("Ok") {
                
            }
        } message: {
            Text("Please enable location services for this app in Settings")
        }
    }
}

