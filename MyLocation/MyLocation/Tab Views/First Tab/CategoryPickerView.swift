//
//  CategoryPickerView.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 25/01/25.
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
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
                

            }
            .listStyle(.inset)
        }
    }
}

#Preview {
    CategoryPickerView(selectedCategory: .constant("No Category"))
}
