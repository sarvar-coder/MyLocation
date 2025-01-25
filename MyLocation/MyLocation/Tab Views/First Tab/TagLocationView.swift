//
//  TagLocationView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 25/01/25.
//

import SwiftUI

struct TagLocationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    var body: some View {
        
        VStack {
            descriptionTextField
            category
            addPhotoButton
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
        Divider()
        HStack {
            Text("Category")
            Spacer()
            Text("Bookstore")
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        Divider()
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    var addPhotoButton: some View {
        Divider()
        HStack {
            Text("Add Photo")
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding()
        Divider()
            .padding(.bottom, 40)
    }
    
    @ViewBuilder
    var latitude: some View {
        Divider()
        HStack {
            Text("Latitude:")
            Spacer()
            Text("12.12345678")
        }
        .padding()
        Divider()
    }
    
    @ViewBuilder
    var longitude: some View {
        HStack {
            Text("Longitude:")
            Spacer()
            Text("-12.12345678")
        }
        .padding()
        Divider()
    }
    
    @ViewBuilder
    var address: some View {
        HStack {
            Text("Address:")
            Spacer()
            Text("Uzbekistan, Xorazam vil, Hazorasp tum, Paxlavon Maxmud, G.Gulom 34/9")
                .lineLimit(0)
                
        }
        .padding()
        Divider()
    }
    @ViewBuilder
    var date: some View {
        HStack {
            Text("Date:")
            Spacer()
            Text("\(Date().description)")
        }
        .padding()
        Divider()
    }
    
}

#Preview {
    NavigationStack {
        TagLocationView()
    }
}
