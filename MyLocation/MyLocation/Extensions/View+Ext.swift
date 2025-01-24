//
//  View+Ext.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 24/01/25.
//

import Foundation
import SwiftUI

extension View {
    func center() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
