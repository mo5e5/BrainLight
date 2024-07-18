//
//  GameInfoSheet.swift
//  BrainLight
//
//  Created by Malte Oppermann on 21.06.24.
//

import SwiftUI

struct GameInfoSheet: View {
    
    // MARK: - Properties
    
    @Binding var showInfo: Bool
    
    var gameInfo: GameType
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(gameInfo.headText)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding()
                
                Text(gameInfo.infoText)
                    .foregroundStyle(.black)
                    .padding()
                
                Spacer()
                ActionButton(title: "OK", buttonColor: .green) {
                    showInfo = false
                }
                .padding()
            }
            .padding()
            .navigationBarItems(trailing: Button("Back") {
                showInfo = false
            })
        }
    }
    
}

#Preview {
    GameInfoSheet(showInfo: .constant(true), gameInfo: .cookieClicker)
}
