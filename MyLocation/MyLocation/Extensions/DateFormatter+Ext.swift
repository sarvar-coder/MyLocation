//
//  DateFormatter+Ext.swift
//  MyLocation
//
//  Created by Sarvar Boltaboyev on 25/01/25.
//

import Foundation

extension Date {
    var dateFormatter: String  {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
