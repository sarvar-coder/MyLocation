//
//  TagLocationView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 25/01/25.
//

import SwiftUI
import CoreLocation
import PhotosUI
import AVFoundation


struct TagLocationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    @State private var descriptionText = ""
    @AppStorage("selectedcategory") private var selectedCategory = "No Category"
    @State private var showHudView = false
    @FocusState private var keyBoarHidden: Bool
    
    @State private var prossedImage: Image?
    @State private var selectedImage: PhotosPickerItem?
    @State private var showAlert = false
    @State private var showLibrary = false
    
    let boxWidth: CGFloat = 96
    let boxHeight: CGFloat = 96
    let uiColor: Color = Color(uiColor: UIColor(white: 0.3, alpha: 0.8))
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placeMark: CLPlacemark?
    
    var body: some View {
        
        ZStack {
            if showHudView {
                HudView()
                    .zIndex(1)
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showHudView = false
                            }
                        }
                    }
            }
            ScrollView {
                VStack {
                    content
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    save()
                    withAnimation {
                        showHudView = true
                    }
                } label: {
                    Text("Done")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                    
                } label: {
                    Text("Close")
                }
            }
        }
        .navigationTitle("Tag Location")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    var content: some View {
        descriptionTextField
        VStack {
            NavigationLink {
                CategoryPickerView(selectedCategory: $selectedCategory)
            } label: {
                categoryButton
            }
            NavigationLink {
                Text("Photo picker")
            } label: {
                addPhotoButton
            }
            
            latitude
            longitude
            address
            date
            Spacer()
        }
        .onTapGesture { keyBoarHidden = false }
    }
    
    @ViewBuilder
    var descriptionTextField: some View {
        TextField("Description", text: $descriptionText)
            .focused($keyBoarHidden)
            .padding([.leading, .trailing, .top])
        Divider()
            .padding(.bottom, 30)
    }
    
    @ViewBuilder
    var categoryButton: some View {
        
        HStack {
            Text("Category")
            Spacer()
            Text(selectedCategory)
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
    
    @ViewBuilder
    var addPhotoButton: some View {
        
        PhotosPicker(selection: $selectedImage) {
            if let prossedImage {
                prossedImage
                    .resizable()
                    .frame(width: 200, height: 200)
                    .aspectRatio(contentMode: .fill)
            } else {
                HStack {
                    Text("Add Photo")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                .padding()
            }
        }.onChange(of: selectedImage, loadImage)
    }
    
    @ViewBuilder
    var latitude: some View {
        Divider()
        HStack {
            Text("Latitude:")
            Spacer()
            Text(String(format:"%.8f", coordinate.latitude))
        }
        .padding()
        Divider()
    }
    
    @ViewBuilder
    var longitude: some View {
        HStack {
            Text("Longitude:")
            Spacer()
            Text(String(format:"%.8f", coordinate.longitude))
        }
        .padding()
        Divider()
    }
    
    @ViewBuilder
    var address: some View {
        HStack {
            Text("Address:")
            Spacer()
            if let placeMark {
                Text(string(from: placeMark))
                    .layoutPriority(0)
            }  else {
                Text("No Address Found")
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        Divider()
    }
    @ViewBuilder
    var date: some View {
        HStack {
            Text("Date:")
            Spacer()
            Text(Date().dateFormatter)
        }
        .padding()
        Divider()
    }
    
    //  MARK: - Helper Methods
    private func save() {
        let location = Location(context: context)
        
        location.locationDescription = descriptionText
        location.category = selectedCategory
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.placemark = placeMark
        location.date = Date()
        
        if let selectedImage  = selectedImage {
            if !location.hasPhoto {
                location.photoID = Location.nextPhotoID() as NSNumber
            }
            
            Task {
                if let data = try await selectedImage.loadTransferable(type: Data.self)  {
                    try data.write(to: location.photoURL, options: .atomic)
                }
            }
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func loadImage()  {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return}
            
            prossedImage = Image(uiImage: inputImage)
        }
    }
}

#Preview {
    NavigationStack {
        TagLocationView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
