//
//  BraintisticView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 10.06.24.
//

import SwiftUI

struct BraintisticView: View {
    
    // MARK: - Properties
    
    @StateObject private var braintisticsViewModel: BraintisticsViewModel = BraintisticsViewModel()
    
    @State private var selectedView: StatViewType = .user
    @State private var selectedGame: GameType = .cookieClicker
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Picker("Select Game", selection: $selectedGame) {
                        ForEach(GameType.allCases.filter { $0 != .moreComingSoon}) { game in
                            Text(game.headText).tag(game)
                        }
                    }
                    .background(.yellow.opacity(0.2))
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Select View", selection: $selectedView) {
                        ForEach(StatViewType.allCases) { view in
                            Text(view.title).tag(view)
                        }
                    }
                    .background(.green.opacity(0.2))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 250)
                    
                    switch selectedGame {
                    case .cookieClicker:
                        switch selectedView {
                        case .user:
                            CookieClickerUserStatView()
                                .environmentObject(braintisticsViewModel)
                        case .global:
                            CookieClickerGlobalStatView()
                                .environmentObject(braintisticsViewModel)
                        }
                    case .guessRight:
                        switch selectedView {
                        case .user:
                            GuessRightUserStatView()
                                .environmentObject(braintisticsViewModel)
                        case .global:
                            GuessRightGlobalStatView()
                                .environmentObject(braintisticsViewModel)
                        }
                    case .moreComingSoon:
                        EmptyView()
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}
