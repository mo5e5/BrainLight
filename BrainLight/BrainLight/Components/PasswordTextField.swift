//
//  PasswordTextField.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct PasswordTextField: View {
    
    // MARK: - Properties
    
    @Binding var switchView: Bool
    @Binding var text: String
    
    var image: String
    var title: String
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            HStack {
                if switchView {
                    Image(systemName: image)
                        .foregroundStyle(.gray)
                    TextField(title, text: $text)
                        .frame(minHeight: 38)
                } else {
                    Image(systemName: image)
                        .foregroundStyle(.gray)
                    SecureField(title, text: $text)
                        .frame(minHeight: 38)
                }
                Image(systemName: switchView ? "eye.slash" : "eye")
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        switchView.toggle()
                    }
            }
            Divider()
        }
    }
    
}

#Preview {
    PasswordTextField(switchView: .constant(false), text: .constant("123456"), image: "person", title: "Password")
}
