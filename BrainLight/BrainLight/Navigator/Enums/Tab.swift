//
//  Tab.swift
//  BrainLight
//
//  Created by Malte Oppermann on 10.06.24.
//

import SwiftUI

enum Tab: String, Identifiable, CaseIterable {
    case home, statistic, settings
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .statistic: return "Braintistics"
        case .settings: return "Settings"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .statistic: return "list.bullet.clipboard"
        case .settings: return "gear"
        }
    }
    
    var view: AnyView {
        switch self {
        case .home: return AnyView(HomeView())
        case .statistic: return AnyView(BraintisticView())
        case .settings: return AnyView(SettingsView())
        }
    }
    
}
