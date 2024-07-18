//
//  GameType.swift
//  BrainLight
//
//  Created by Malte Oppermann on 21.06.24.
//

import Foundation
import SwiftUI

enum GameType: String, CaseIterable, Identifiable {
    case cookieClicker, guessRight, moreComingSoon
    
    var id: String { rawValue }
    
    var headText: String {
        switch self {
        case .cookieClicker: return "Cookie Clicker"
        case .guessRight: return "Guess Right"
        case .moreComingSoon: return "More Coming Soon"
        }
    }
    
    var infoText: String {
        switch self {
        case .cookieClicker: return "In CookieClicker, you have to click on the cookie as many times as possible within one minute to increase the counter. You have 60 seconds, but you won't see how much time is left. After the 60 seconds are up, you will be automatically redirected to the home screen. You can view your result later in the braintistics."
        case .guessRight: return "In Guess Right, you will be presented with a series of 10 questions. Choose the correct answer from the options provided. You can view your result later in the braintistics."
        case .moreComingSoon: return ""
        }
    }
    
    var image: String {
        switch self {
        case .cookieClicker: return "CookieImage"
        case .guessRight: return "QuestionmarkImage"
        case .moreComingSoon: return "WaitForIt"
        }
    }
    
   
    var view: AnyView {
        switch self {
        case .cookieClicker: return AnyView(CookieClickerView())
        case .guessRight: return AnyView(GuessRightView())
        case .moreComingSoon: return AnyView(EmptyView())
        }
    }
    
    var isEnabled: Bool {
        return self != .moreComingSoon
    }
}
