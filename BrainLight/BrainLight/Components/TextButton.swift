//
//  TextButton.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct TextButton: View {
    
    // MARK: - Properties
    
    let title: String
    let coloredTitle: String
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.gray)
                .font(.headline)
            Button(action: action) {
                Text(coloredTitle)
                    .foregroundStyle(.green)
                    .font(.headline)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    TextButton(title: "Sign up", coloredTitle: "here") { }
}
