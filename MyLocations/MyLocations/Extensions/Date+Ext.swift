//
//  Date+Ext.swift
//  MyLocations
//
//  Created by Sarvar Boltaboyev on 10/04/25.
//

import Foundation

extension Date {
    var customFormatter: String {
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateStyle = .medium
        dateFormmatter.timeStyle = .short
        
        return dateFormmatter.string(from: self)
    }
}
