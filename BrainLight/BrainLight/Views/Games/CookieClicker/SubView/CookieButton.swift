//
//  CookieButton.swift
//  BrainLight
//
//  Created by Malte Oppermann on 19.06.24.
//

import SwiftUI

struct CookieButton: View {
    
    // MARK: - Properties
    
    @Binding var buttonPosition: CGPoint
    
    var increaseCounter: () -> Void
    var image: String = "CookieImage"
    
    // MARK: - Body
    
    var body: some View {
        Button {
            increaseCounter()
            buttonPosition = CGPoint(x: CGFloat.random(in:-170...170),
                                     y: CGFloat.random(in: -300...300))
        } label: {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
        }
    }
    
}
