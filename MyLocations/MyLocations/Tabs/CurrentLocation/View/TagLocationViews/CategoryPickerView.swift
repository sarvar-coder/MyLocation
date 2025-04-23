//
//  CategoryPickerView.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 10/04/25.
//

import SwiftUI

struct CategoryPickerView: View {
    
    @Binding var selectedCategory: String
    
    var categories = [
        "No Category",
        "Apple Store",
        "Bar",
        "Bookstore",
        "Club",
        "Grocery Store",
        "Historic Building",
        "House",
        "Icecream Vendor",
        "Landmark",
        "Park"
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(categories, id: \.self) { category in
                        HStack {
                            Text(category)
                            Spacer()
                            if selectedCategory == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .listStyle(.inset)
        }
        .navigationTitle("Categoires")
    }    
}
