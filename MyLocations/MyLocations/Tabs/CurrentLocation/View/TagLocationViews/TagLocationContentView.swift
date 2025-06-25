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
    
    @State private var isPresented = false
    @State private var photoSelection: PhotoSelection?
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
                DescriptionView()
                
                CategoryPicker()
                
                Text("")
                
                if thumbImage == nil {
                    PhotoPicker()
                    
                    Text("")
                    
                    CameraPicker()
                } else {
                  ImageView()
                }
                
                Text("")
                
                AddresView()
                    .padding([.vertical], 10)
            }
            .listStyle(.plain)
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
    
    func DescriptionView() -> some View {
        Section("Description") {
            TextEditor(text: $text)
                .frame(height: 88)
                .border(.gray, width: 1)
                .lineLimit(3)
                .cornerRadius(8)
                .background(.gray.opacity(0.8))
                .focused($keyBoardHidden)
        }
    }
    
    func CategoryPicker() -> some View {
        Section {
            NavigationLink(destination: CategoryPickerView(selectedCategory: $selectedCategory)) {
                HStack {
                    Text("Category")
                    Spacer()
                    Text(selectedCategory)
                }
            }
        }
    }
    
    func PhotoPicker() -> some View {
        PhotosPicker(selection: $photoItem, matching: .images) {
           
//            else {
                HStack {
                    Text("Add photo")
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
//            }
        }
    }
    
    func CameraPicker() -> some View {
        
        NavigationLink {
            CameraView(image: $thumbImage)
        } label: {
            Text("Take photo")
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        if let thumbImage {
            HStack(alignment: .center) {
                Image(uiImage: thumbImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300 * 9 / 16)
                    .cornerRadius(5)
                    
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    self.thumbImage = nil
                } label : {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .imageScale(.large)
                        .padding(.trailing, 20)
                }
            }
        }
    }
    
    @ViewBuilder
    func AddresView() -> some View {
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
    }
}

//    .confirmationDialog("Choose to add photo", isPresented: $isPresented) {
//        Button {
//            photoSelection = .fromPhotos
//        } label: {
//            Text("From Photos")
//        }
//
//        Button {
//            photoSelection = .fromCamera
//        } label: {
//            Text("From Camera")
//        }
//    }

