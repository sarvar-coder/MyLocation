//
//  TagLocationView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 10/04/25.
//

import SwiftUI
import CoreLocation
import UIKit
import PhotosUI

struct TagLocationView: View {
    
    @Environment(\.managedObjectContext) private var viewcontext
    @Environment(\.dismiss) var dismiss
    @State private var text = ""
    @State private var selectedCatgory: String = "No Category"
    @State private var isPresentedHudView = false
    @State private var photoItem: PhotosPickerItem?
    @State private var thumbImage: UIImage?
    
    var coordinate: Coordinate
    var placeMark: CLPlacemark?
    var location: Location?
    let updateLocation: ((Location) -> Void)
    
    var body: some View {
        NavigationStack {
            ZStack {
                
//  MARK: - Hud View
                hudView
                
// MARK: Content View
                contentView
                
// MARK: Tool Bar
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if !(location != nil) {
                            Button("Cancel") {
                                dismiss()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(location != nil ? "Update" : "Done") {
                            withAnimation(.easeIn) { isPresentedHudView = true }
                            if let location {
                                self.updateLocation(location)
                            } else {
                                self.saveLocation()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                dismiss()
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(location != nil ? "Edit Location" : "Tag Location")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    var hudView: some View {
        if isPresentedHudView {
            HudView(location: location)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline:.now() + 1) {
                        withAnimation(.easeOut) {
                            isPresentedHudView = false
                        }
                    }
                }
                .zIndex(1)
        }
    }
    
    var contentView: some View {
        TagLocationContentView(
            text: Binding(get: {
            location?.desript ?? text
            }, set: { newValue in
                if let location {
                    location.desript = newValue
                } else {
                    text = newValue
                }
                
            }),
            
            selectedCategory: Binding(get: {
                location?.category ?? selectedCatgory
            }, set: { newValue in
                
                if let location {
                    location.category = newValue
                } else {
                    selectedCatgory = newValue
            }
        }),
            photoItem: $photoItem,
            thumbImage: $thumbImage,
            coordinate: coordinate,
            placemark: location != nil ? location?.placemark : placeMark)
    }
}

extension TagLocationView {
//    MARK: - CoreData Helper methods
    
    func saveLocation() {
        let location = Location(context: viewcontext)
        
        location.id = UUID().uuidString
        location.category = selectedCatgory
        location.date = Date()
        location.desript = text
        location.latitude = Double(coordinate.latitude) ?? 0
        location.longitude = Double(coordinate.longitude) ?? 0
        location.placemark = placeMark
        location.photoID = nil
        
        if let image = thumbImage {
            print(!location.hasPhoto, "foo1", location.photoID)
            if !location.hasPhoto {
                location.photoID = NSNumber(value: Location.nextPhotoID())
            }
            
            if let data = image.jpegData(compressionQuality: 0.5) {
                do {
                    try data.write(to: location.photoURL, options: .atomic)
                } catch {
                    print(error.localizedDescription, "Saving error")
                }
            }
        }
        
        do {
            try viewcontext.save()
            
        } catch {
            debugPrint(error.localizedDescription, "foo")
        }
//        location.photoID = nil 
    }
    
//    func saveImage(image: UIImage?, location: Location) {
//        if let image = image  {
//            
//            print(!location.hasPhoto, location.photoID, "foo 1")
//            if !location.hasPhoto {
//                location.photoID = Location.nextPhotoID() as NSNumber
//            }
//     
//            if let data = image.jpegData(compressionQuality: 0.5) {
//                do {
//                    print("saved", "Foo")
//                    try data.write(to: location.photoURL, options: .atomic)
//                } catch {
//                    print("Error while saving, FOO \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}

#Preview {
    NavigationStack {
        TagLocationView(coordinate: Coordinate(latitude: "0", longitude: "0")) {_ in}
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}


