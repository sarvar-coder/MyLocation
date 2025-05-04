//
//  ContainerView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 04/05/25.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    
    var isPresented: Bool
    let content: () -> Content
    
    init(isPresented: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isPresented = isPresented
        self.content = content
    }
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    ContainerView(isPresented: true) {
       Text("Sarvar")
    }
}
