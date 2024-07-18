//
//  DateExtension.swift
//  BrainLight
//
//  Created by Malte Oppermann on 26.06.24.
//

import Foundation

// MARK: - Functions

extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM."
        return formatter.string(from: self)
    }
}
