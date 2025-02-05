//
//  TagLocationView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 25/01/25.
//

import SwiftUI
import CoreLocation

struct TagLocationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) private var locations: FetchedResults<Location>
    @State private var descriptionText = ""
    @AppStorage("selectedcategory") private var selectedCategory = "No Category"
    @State private var showHudView = false
    @FocusState private var keyBoarHidden: Bool
    @State private var savedOnce = true
    
    
    let boxWidth: CGFloat = 96
    let boxHeight: CGFloat = 96
    let uiColor: Color = Color(uiColor: UIColor(white: 0.3, alpha: 0.8))
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placeMark: CLPlacemark?
    
    var body: some View {
        
        ZStack {
            if showHudView {
                HudView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showHudView = false
                            }
                        }
                    }
            }
            VStack {
                content
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {

                    save()
                    savedOnce = false
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
                    savedOnce = true
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
                category
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
            .padding(.bottom, 70)
    }
    
    @ViewBuilder
    var category: some View {
        
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
        
        HStack {
            Text("Add Photo")
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
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
        do {
            if savedOnce {
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        TagLocationView()
            .environment(\.managedObjectContext, PersistenceController.preview.viewContext)
    }
}
