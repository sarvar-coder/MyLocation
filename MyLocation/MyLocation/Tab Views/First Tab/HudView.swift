//
//  HudView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 26/01/25.
//

import SwiftUI

struct HudView: View {
    
    let boxWidth: CGFloat = 96
    let boxHeight: CGFloat = 96
    let uiColor: Color = Color(uiColor: UIColor(white: 0.3, alpha: 0.8))
    
    var body: some View {
        ZStack {
            box
                .overlay(boxContent)
        }
    }
    @ViewBuilder
    var box: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 15.0)
                .fill(uiColor)
            
                .frame(width: boxWidth, height: boxHeight)
                .position(
                    x: geometry.size.width / 2,
                    y: geometry.size.height / 2
                )
        }
    }
    var boxContent: some View {
        VStack() {
            Image("myCheckmark")
                .imageScale(.large)
                .foregroundColor(.white)
            
            Text("Tagged")
                .foregroundStyle(.white)
                .font(.system(size: 16))
        }
    }
}

#Preview {
    HudView()
}
