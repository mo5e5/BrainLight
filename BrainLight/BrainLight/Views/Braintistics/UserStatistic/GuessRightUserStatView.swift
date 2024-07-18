//
//  GuessRightUserStatView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.07.24.
//

import SwiftUI

struct GuessRightUserStatView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    @EnvironmentObject private var braintisticsViewModel: BraintisticsViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if braintisticsViewModel.guessRightUserResults.isEmpty {
                VStack {
                    Spacer()
                    Text("No Results available.")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(braintisticsViewModel.guessRightUserResults.indices, id: \.self) { index in
                            let result = braintisticsViewModel.guessRightUserResults[index]
                            HStack {
                                Text("\(index + 1).")
                                    .frame(maxWidth: 30, alignment: .leading)
                                Text("You got \(result.amount) Correct Answers.")
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
            if let userId = userViewModel.user?.id {
                braintisticsViewModel.fetchGuessRightUserResults(userId: userId)
            }
        }
    }
}

#Preview {
    GuessRightUserStatView()
        .environmentObject(UserViewModel())
        .environmentObject(BraintisticsViewModel())
}


