//
//  AuthenticationView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI

struct AuthenticationView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var switchViewPassword: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 28) {
            VStack {
                Text("Welcome to Brain Light.")
                    .font(.title)
                    .fontWeight(.semibold)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 300)
                    .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 0, paddingHorizontalTwo: 0, shadowRadius: 2)
            }
            VStack(spacing: 14) {
                if userViewModel.mode == .register {
                    DefaultTextField(text: $userViewModel.name, image: "person", title: "Name")
                }
                DefaultTextField(text: $userViewModel.email, image: "envelope", title: "E-Mail")
                PasswordTextField(switchView: $switchViewPassword, text: $userViewModel.password, image: "lock", title: "Password")
            }
            .font(.headline)
            .textInputAutocapitalization(.never)
            
            ActionButton(title: userViewModel.mode.title, buttonColor: .cyan) {
                userViewModel.auhenticate()
            }
            .disabled(userViewModel.disableAuthentication)
            
            TextButton(title: userViewModel.mode.alternativeTitle, coloredTitle: userViewModel.mode.coloredPart) {
                withAnimation {
                    userViewModel.switchAuthenticationMode()
                }
            }
            
        }
        .padding(45)

        .alert(isPresented: $userViewModel.showAlert) {
            withAnimation {
                Alert(title: Text("Ups ...\n Something went wrong."), message: Text(userViewModel.alertMessage), dismissButton: .default(Text("Ok")))
            }
            
        }
    }
    
}

#Preview {
    AuthenticationView()
        .environmentObject(UserViewModel())
}
