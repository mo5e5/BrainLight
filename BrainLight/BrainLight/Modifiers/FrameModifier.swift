//
//  FrameModifier.swift
//  BrainLight
//
//  Created by Malte Oppermann on 10.07.24.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    
    // MARK: - Properties
    
    var cornerRadiusOne: CGFloat
    var strokeColor: Color
    var cornerRadiusTwo: CGFloat
    var backgroundColor: Color
    
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadiusOne)
                    .stroke(strokeColor, lineWidth: 2)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadiusTwo)
                            .fill(backgroundColor)
                    )
            )
    }
}

// MARK: - Extension

extension View {
    
    func frameModifier(corenerRadiusOne: CGFloat, strokeColor: Color, cornerRadiusTwo: CGFloat, backgroundColor: Color) -> some View {
        modifier(FrameModifier(cornerRadiusOne: corenerRadiusOne, strokeColor: strokeColor, cornerRadiusTwo: cornerRadiusTwo, backgroundColor: backgroundColor))
    }
}

#Preview {
    Text("Hello")
        .frameModifier(corenerRadiusOne: 12, strokeColor: .green, cornerRadiusTwo: 12, backgroundColor: .white)
}
