//
//  PasswordChangeSheet.swift
//  BrainLight
//
//  Created by Malte Oppermann on 17.06.24.
//

import SwiftUI

struct PasswordChangeSheet: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var newPassword: String = ""
    @State private var switchView: Bool = false
    
    @Binding var passwordSheet: Bool
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                PasswordTextField(switchView: $switchView, text: $newPassword, image: "lock", title: "New Password")
                ActionButton(title: "Change Password", buttonColor: .cyan) {
                    userViewModel.showAlert = true
                }
            }
            .clipShapeModifier(paddingVertical: 12, paddingHorizontal: 12, cornerRadius: 12, paddingHorizontalTwo: 18, shadowRadius: 10)
            .navigationTitle("Change your Password")
            .navigationBarItems(trailing: Button("cancel") {
                passwordSheet = false
            })
            .alert(isPresented: $userViewModel.showAlert) {
                withAnimation {
                    Alert(
                        title: Text("Do you really want to change your password?"),
                        primaryButton: .default(Text("Yes")) {
                            userViewModel.changePassword(newPassword: newPassword)
                            passwordSheet = false
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
    }
    
}

#Preview {
    PasswordChangeSheet(passwordSheet: .constant(false))
        .environmentObject(UserViewModel())
}
