//
//  FireUser.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import Foundation

struct FireUser: Codable {
    let id: String 
    var name: String
    var email: String
    let registeredAt: Date
}
