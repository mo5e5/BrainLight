//
//  HomeView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var zenQuoteViewModel: ZenQuoteViewModel = ZenQuoteViewModel()
    
    @State private var selectedGame: GameType?
    @State private var showSettings: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text(zenQuoteViewModel.quote.q)
                        .font(.title2)
                        .frame(maxWidth: .infinity, minHeight: 150, alignment: .center)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
                    Text(zenQuoteViewModel.quote.a)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
                .padding()
                .frameModifier(corenerRadiusOne: 20, strokeColor: .black, cornerRadiusTwo: 4, backgroundColor: .yellow.opacity(0.1))
                .clipShapeModifier(paddingVertical: 1, paddingHorizontal: 1, cornerRadius: 2, paddingHorizontalTwo: 0, shadowRadius: 3)
                .padding()
                
                HStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundStyle(.black)
                        .cornerRadius(20)
                    AnimatedHeader()
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundStyle(.black)
                        .cornerRadius(20)
                }
                
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(GameType.allCases) { game in
                            Button {
                                selectedGame = game
                            } label: {
                                GameField(gameInfo: game)
                            }
                            .disabled(!game.isEnabled)
                        }
                        .scaledToFit()
                        .frameModifier(corenerRadiusOne: 20, strokeColor: .black, cornerRadiusTwo: 4, backgroundColor: .yellow.opacity(0.1))
                        .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 20, paddingHorizontalTwo: 0, shadowRadius: 2)
                        .containerRelativeFrame(.horizontal)
                        .scrollTransition(axis: .horizontal) { content, phase in
                            content
                                .rotation3DEffect(.degrees(phase.value * -30.0), axis: (x: phase.value, y: 1, z: 0))
                                .scaleEffect(x: phase.isIdentity ? 1 : 0.8, y: phase.isIdentity ? 1 : 0.8)
                        }
                    }
                }
                .contentMargins(10)
                .scrollIndicators(.hidden)
            }
            .padding()
            .onAppear {
                zenQuoteViewModel.fetchData()
            }
            .fullScreenCover(item: $selectedGame) { game in
                NavigationView {
                    game.view
                }
            }
        }
    }
    
}

#Preview {
    HomeView()
}
