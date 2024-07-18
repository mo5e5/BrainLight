//
//  ClipShapeModifire.swift
//  BrainLight
//
//  Created by Malte Oppermann on 12.06.24.
//

import SwiftUI

struct ClipShapeModifier: ViewModifier {
    
    // MARK: - Properties
    
    var paddingVertical: CGFloat
    var paddingHorizontal: CGFloat
    var cornerRadius: CGFloat
    var paddingHorizontalTwo: CGFloat
    var shadowRadius: CGFloat
    
    // MARK: - Body
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, paddingVertical)
            .padding(.horizontal, paddingHorizontal)
            .clipShape(.rect(cornerRadius: cornerRadius))
            .padding(.horizontal, paddingHorizontalTwo)
            .frame(maxWidth: .infinity)
            .shadow(color: .black.opacity(0.2), radius: shadowRadius, x: 0, y: 4)
    }
}

// MARK: - Extension

extension View {
    
    func clipShapeModifier(paddingVertical: CGFloat, paddingHorizontal: CGFloat, cornerRadius: CGFloat, paddingHorizontalTwo: CGFloat, shadowRadius: CGFloat) -> some View {
        modifier(ClipShapeModifier(paddingVertical: paddingVertical, paddingHorizontal: paddingHorizontal, cornerRadius: cornerRadius, paddingHorizontalTwo: paddingHorizontalTwo, shadowRadius: shadowRadius))
    }
}

#Preview {
    Text("hello")
        .clipShapeModifier(paddingVertical: 14, paddingHorizontal: 14, cornerRadius: 12, paddingHorizontalTwo: 2, shadowRadius: 10)
}
