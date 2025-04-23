//
//  Button+Ext.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 07/04/25.
//

import Foundation
import SwiftUI

extension Button {
    
    func showAlert(isPresented: Binding<Bool>) -> some View {
          
        alert("Locations Services Disabled", isPresented: isPresented) {
             
        } message: {
            Text("Please enable location services for this app in Settings")
        }


    }
}
