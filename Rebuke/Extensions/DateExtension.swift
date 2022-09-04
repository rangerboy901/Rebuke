//
//  DateExtension.swift
//  Rebuke
//
//  Created by Joseph Wil;liam DeWeese on 8/24/22.
//

import Foundation

extension Date {
    
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
}
