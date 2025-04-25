//
//  TagLocationContentView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 10/04/25.
//

import SwiftUI
import CoreLocation
import PhotosUI
import UIKit

struct TagLocationContentView: View {
    
    @Binding var text: String
    @Binding var selectedCategory: String
    @FocusState private var keyBoardHidden: Bool
    @Binding var photoItem: PhotosPickerItem?
    @Binding var thumbImage: UIImage?
    
    var coordinate: Coordinate
    var placemark: CLPlacemark?
    
    var body: some View {
        VStack {
            
            List {
                
                Section("Description") {
                    TextEditor(text: $text)
                        .frame(height: 88)
                        .border(.gray, width: 1)
                        .lineLimit(3)
                        .cornerRadius(8)
                        .background(.gray.opacity(0.8))
                        .focused($keyBoardHidden)
                    
                }
                
                Section {
                    NavigationLink(destination: CategoryPickerView(selectedCategory: $selectedCategory)) {
                        HStack {
                            Text("Category")
                            Spacer()
                            Text(selectedCategory)
                        }
                    }
                }
                
                Text("")
                PhotosPicker(selection: $photoItem, matching: .images) {
                    if let thumbImage {
                        HStack(alignment: .center) {
                            Image(uiImage: thumbImage)
                                .resizable()
                                .frame(width: 300, height: 300 * 9 / 16)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(5)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                    } else {
                        HStack {
                            Text("Add photo")
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                        }
                    }
                }
                
                
                Text("")
                
                Section {
                    HStack {
                        Text("Latatitude")
                        Spacer()
                        Text(coordinate.latitude)
                    }
                    
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text(coordinate.longitude)
                    }
                    
                    HStack {
                        Text("Address")
                        Spacer()
                        if let placemark {
                            Text(string(from: placemark))
                        } else {
                            Text("No Address Found")
                        }
                        
                    }
                    
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(Date().customFormatter)
                    }
                }
                .padding([.vertical], 10)
                
            }
            .listStyle(.plain)
            
        }
        .onChange(of: photoItem) { _, _ in
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
