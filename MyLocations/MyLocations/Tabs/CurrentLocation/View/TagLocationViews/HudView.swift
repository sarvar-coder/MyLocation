//
//  HudView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 12/04/25.
//

import Foundation
import SwiftUI

struct HudView: View {
    let location: Location?
    var body: some View {
        VStack {
           RoundedRectangle(cornerRadius: 10)
                .fill(Color(uiColor: UIColor(white: 0.3, alpha: 0.8)))
                .frame(width: 96, height: 96)
                .overlay {
                    VStack {
                        Image(uiImage: UIImage(named: "mycheckmark")!)
                            .tint(.white)
                        Text(location != nil ? "Updated" : "Tagged")
                            .foregroundStyle(.white)
                            .bold()
                    }
                }
        }
    }
}
