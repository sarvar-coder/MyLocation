//
//  File.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 06/04/25.
//

import SwiftUI

extension View {
    func centerView() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
