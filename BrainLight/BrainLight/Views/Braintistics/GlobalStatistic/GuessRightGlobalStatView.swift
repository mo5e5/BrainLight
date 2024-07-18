//
//  GuessRightGlobalStatView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.07.24.
//

import SwiftUI

struct GuessRightGlobalStatView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var braintisticsViewModel: BraintisticsViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if braintisticsViewModel.guessRightGlobalUserResults.isEmpty {
                VStack {
                    Spacer()
                    Text("No Results available.")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(braintisticsViewModel.guessRightGlobalUserResults.indices, id: \.self) { index in
                            let result = braintisticsViewModel.guessRightGlobalUserResults[index]
                            HStack {
                                Text("\(index + 1).")
                                    .frame(maxWidth: 30, alignment: .leading)
                                Text("\(result.userName) has overall \(result.amount) Correct Answers in \(result.gamesPlayed) \(result.gamesPlayed == 1 ? "game" : "games").")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .scrollTransition(axis: .vertical) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0)
                                .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                .blur(radius: phase.isIdentity ? 0 : 10)
                        }
                    }
                    .padding()
                }
            }
        }
        .frameModifier(corenerRadiusOne: 12, strokeColor: .black, cornerRadiusTwo: 12, backgroundColor: .yellow.opacity(0.2))
        .clipShapeModifier(paddingVertical: 1, paddingHorizontal: 1, cornerRadius: 2, paddingHorizontalTwo: 0, shadowRadius: 3)
        
        .padding()
        .onAppear {
            braintisticsViewModel.fetchGuessRightGlobalResults()
        }
    }
}

#Preview {
    GuessRightGlobalStatView()
        .environmentObject(BraintisticsViewModel())
}
