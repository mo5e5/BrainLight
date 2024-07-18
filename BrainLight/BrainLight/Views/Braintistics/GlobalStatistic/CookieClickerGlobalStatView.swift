//
//  GlobalStatView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 27.06.24.
//

import SwiftUI

struct CookieClickerGlobalStatView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var braintisticsViewModel: BraintisticsViewModel
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if braintisticsViewModel.cookieClickerGlobaleResults.isEmpty {
                VStack {
                    Spacer()
                    Text("No Results available.")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        ForEach(braintisticsViewModel.cookieClickerGlobaleResults.indices, id: \.self) { index in
                            let result = braintisticsViewModel.cookieClickerGlobaleResults[index]
                            HStack {
                                Text("\(index + 1).")
                                    .frame(maxWidth: 30, alignment: .leading)
                                Text("\(result.userName) with \(result.amount) Clicks.")
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
            braintisticsViewModel.fetchCookieClickerGlobaleResults()
        }
    }
    
}

#Preview {
    CookieClickerGlobalStatView()
        .environmentObject(BraintisticsViewModel())
}
