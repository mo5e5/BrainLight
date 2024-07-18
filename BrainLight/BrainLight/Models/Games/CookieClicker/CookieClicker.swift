//
//  CookieClicker.swift
//  BrainLight
//
//  Created by Malte Oppermann on 19.06.24.
//

import Foundation

struct CookieClicker: Codable, Identifiable {
    var id: UUID = UUID()
    
    var amount: Int
    var playedAt: Date
}
