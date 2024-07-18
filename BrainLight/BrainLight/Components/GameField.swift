//
//  GameField.swift
//  BrainLight
//
//  Created by Malte Oppermann on 11.06.24.
//

import SwiftUI

struct GameField: View {
    
    // MARK: - Properties
    
    @State private var showInfo: Bool = false
    
    var gameInfo: GameType
   
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                if gameInfo.isEnabled {
                    Button {
                        showInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .sheet(isPresented: $showInfo) {
                        GameInfoSheet(showInfo: $showInfo, gameInfo: gameInfo)
                    }
                }
            }
            .padding(.trailing,10)
            .padding(.top, 10)
            VStack {
                Text(gameInfo.headText)
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontWeight(.semibold)
                Image(gameInfo.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 250, maxHeight: 150)
            }
            .padding()
        }
    }
    
}

#Preview {
    GameField(gameInfo: .cookieClicker)
}
