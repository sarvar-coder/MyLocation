//
//  PhotoPickerView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 21/06/25.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    
    @Binding var photoItem: PhotosPickerItem?
    @Binding var thumbImage: UIImage?
    
    var body: some View {
        PhotosPicker(selection: $photoItem, matching: .images) {

            HStack {
                Text("Add photo")
                Spacer()
                
                Image(systemName: "chevron.right")
            }
        }
        .onChange(of: photoItem) {
            Task {
                if let photoItem,
                   let data = try? await photoItem.loadTransferable(type: Data.self) {
                    self.thumbImage = UIImage(data: data)
                    
                }
                photoItem = nil
            }
        }
    }
}
