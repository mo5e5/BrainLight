//
//  CookieClickerGlobal.swift
//  BrainLight
//
//  Created by Malte Oppermann on 01.07.24.
//

import Foundation

struct CookieClickerGlobal: Identifiable, Codable {
    var id: UUID = UUID()
    
    var userName: String
    var amount: Int
}
