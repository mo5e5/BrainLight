//
//  AnimatedHeader.swift
//  BrainLight
//
//  Created by Malte Oppermann on 11.07.24.
//

import SwiftUI

struct AnimatedHeader: View {
    
    // MARK: - Properties
    
    @State private var gradient = Gradient(colors: [.gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5), .gray.opacity(0.5), .yellow.opacity(0.5)])
    
    @State private var startPoint = UnitPoint(x: 9, y: 3)
    @State private var endPoint = UnitPoint(x: 2, y: 12)
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
                .cornerRadius(20)
                .frame(width: 175, height: 75) // dynamisch machen bei bedarf
                .onAppear {
                    withAnimation(Animation.linear(duration: 12).repeatForever(autoreverses: true)) {
                        startPoint = UnitPoint(x: 10, y: 5)
                        endPoint = UnitPoint(x: 5, y: 17)
                    }
                }
                .frameModifier(corenerRadiusOne: 20, strokeColor: .black, cornerRadiusTwo: 4, backgroundColor: .clear)
            
            Text("G  A  M  E  S")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
        }
    }
    
}

#Preview {
    AnimatedHeader()
}
