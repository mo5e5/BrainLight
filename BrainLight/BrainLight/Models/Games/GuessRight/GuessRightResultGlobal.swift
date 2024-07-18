//
//  GuessRightGlobal.swift
//  BrainLight
//
//  Created by Malte Oppermann on 04.07.24.
//

import Foundation

struct GuessRightResultGlobal: Identifiable, Codable {
    var id: UUID = UUID()
    
    var userName: String
    var amount: Int
    var gamesPlayed: Int
}
