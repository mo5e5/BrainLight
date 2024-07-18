//
//  GuessRightResult.swift
//  BrainLight
//
//  Created by Malte Oppermann on 04.07.24.
//

import Foundation

struct GuessRightResult: Codable, Identifiable {
    var id: UUID = UUID()
    
    var amount: Int
    var playedAt: Date
}
