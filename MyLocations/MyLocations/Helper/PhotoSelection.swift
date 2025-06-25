//
//  PhotoSelection.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 21/06/25.
//

import Foundation
enum PhotoSelection: Identifiable {
    case fromPhotos
    case fromCamera
    
    var id: Int {
        switch self {
        case .fromPhotos:
            return 1
        case .fromCamera:
            return 2
        }
    }
}
