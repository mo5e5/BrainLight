//
//  CookieClickerView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 19.06.24.
//

import SwiftUI

struct CookieClickerView: View {
    
    // MARK: - Properties
    
    @StateObject private var cookieClickerViewModel: CookieClickerViewModel = CookieClickerViewModel()
    
    @State private var buttonPosition: CGPoint = .zero
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Timer
    
    @State private var timeRemaining: Int = 60
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Counter: \(cookieClickerViewModel.cookieClicker.amount)")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top, 45)
            VStack(spacing: 12) {
                withAnimation {
                    CookieButton(buttonPosition: $buttonPosition, increaseCounter: {
                        cookieClickerViewModel.increaseCounter()
                    })
                }
            }
            .offset(x: buttonPosition.x, y: buttonPosition.y)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.upstream.connect().cancel()
                cookieClickerViewModel.saveGame()
                cookieClickerViewModel.saveGlobalGame()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

#Preview {
    CookieClickerView()
}
