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
    @State private var text = ""
    @AppStorage("selectedcategory") private var selectedCategory = "No Category"

    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placeMark: CLPlacemark?
    
    var body: some View {
        
        VStack {
            descriptionTextField
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
        
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
        .navigationTitle("Tag Location")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    @ViewBuilder
    var descriptionTextField: some View {
        TextField("Description", text: $text)
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
    func string(from placemark: CLPlacemark) -> String {
      // 1
      var line1 = ""
      // 2
      if let tmp = placemark.subThoroughfare {
        line1 += tmp + " "
      }
    // 3
      if let tmp = placemark.thoroughfare {
    line1 += tmp }
    // 4
      var line2 = ""
      if let tmp = placemark.locality {
        line2 += tmp + " "
      }
      if let tmp = placemark.administrativeArea {
        line2 += tmp + " "
      }
      if let tmp = placemark.postalCode {
    line2 += tmp }
    // 5
      return line1 + line2
    }
}

#Preview {
    NavigationStack {
        TagLocationView()
    }
}
