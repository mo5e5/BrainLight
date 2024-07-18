//
//  CustomTabButton.swift
//  BrainLight
//
//  Created by Malte Oppermann on 11.07.24.
//

import SwiftUI

struct CustomTabButton: View {
    
    // MARK: - Properties
    
    @State private var gradient = Gradient(colors: [.black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), .black.opacity(0.8), .yellow.opacity(0.7), ])
    
    @State private var startPoint = UnitPoint(x: 9, y: 3)
    @State private var endPoint = UnitPoint(x: 2, y: 12)
    
    var tab: Tab
    var isSelected: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(gradient: isSelected ? gradient : gradient, startPoint: startPoint, endPoint: endPoint)
                    .mask(
                        VStack {
                            if isSelected == true {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 24))
                                    .transition(.symbolEffect)
                                    .scaleEffect(1.5)
                            } else {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 24))
                            }
                            
                        }
                            .padding()
                    )
                    .onAppear {
                            startPoint = UnitPoint(x: 10, y: 3)
                            endPoint = UnitPoint(x: 3, y:15)
                    }
            }
        }
        .frame(width: 100, height: 50)
    }
    
}

#Preview {
    CustomTabButton(tab: .home, isSelected: true)
}
