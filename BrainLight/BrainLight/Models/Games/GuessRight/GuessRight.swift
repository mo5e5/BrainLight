//
//  GuessRight.swift
//  BrainLight
//
//  Created by Malte Oppermann on 03.07.24.
//

import Foundation

struct GuessRight: Codable, Identifiable {
    var id: UUID = UUID()
    
    var image: String?
    var question: String
    var answerOne: String
    var answerTwo: String
    var answerThree: String
    var answerFour: String
    var correctAnswer: Int
}
