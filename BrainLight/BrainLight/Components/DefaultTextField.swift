//
//  DefaultTextField.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct DefaultTextField: View {
    
    // MARK: - Properties
    
    @Binding var text: String
    
    var image: String
    var title: String

    // MARK: -Body
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Image(systemName: image)
                    .foregroundStyle(.gray)
                TextField(title, text: $text)
            }
            
                .frame(minHeight: 38)
            
            Divider()
        }
    }
    
}
