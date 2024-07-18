//
//  ActionButton.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct ActionButton: View {
    
    // MARK: - Properties
    
    let title: String
    let buttonColor: Color
    let action: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
        }
        .padding(.vertical, 14)
        .background(buttonColor)
        .clipShape(.rect(cornerRadius: 14))
    }
    
}

#Preview {
    ActionButton(title: "Login", buttonColor: .blue) { }
}
