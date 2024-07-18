//
//  StatViewType.swift
//  BrainLight
//
//  Created by Malte Oppermann on 27.06.24.
//

import Foundation

enum StatViewType: String, CaseIterable, Identifiable {
    case user, global
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .user: return "User Braintistic"
        case .global: return "Global Braintistics"
        }
    }
    
    var icon: String {
        switch self {
        case .user: return "person"
        case .global: return "globe"
        }
    }
}
