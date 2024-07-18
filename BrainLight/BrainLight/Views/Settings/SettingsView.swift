//
//  SettingsView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 10.06.24.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var userNameSheet: Bool = false
    @State private var passwordSheet: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    if let user = userViewModel.user {
                        Text("Name: \(user.name)")
                            .font(.callout)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        Text("Email: \(user.email)")
                            .font(.callout)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
                .frameModifier(corenerRadiusOne: 12, strokeColor: .black, cornerRadiusTwo: 8, backgroundColor: .yellow.opacity(0.2))
                .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 12, paddingHorizontalTwo: 0, shadowRadius: 3)
                .padding()
                ActionButton(title: "Change Name", buttonColor: .cyan) {
                    userNameSheet = true
                }
                .sheet(isPresented: $userNameSheet, content: {
                    UserNameChangeSheet(userNameSheet: $userNameSheet)
                })
                .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 12, paddingHorizontalTwo: 0, shadowRadius: 3)
                ActionButton(title: "Change Password", buttonColor: .cyan) {
                    passwordSheet = true
                }
                .sheet(isPresented: $passwordSheet, content: {
                    PasswordChangeSheet(passwordSheet: $passwordSheet)
                })
                .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 12, paddingHorizontalTwo: 0, shadowRadius: 3)
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                        .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 0, paddingHorizontalTwo: 0, shadowRadius: 2)
                    Text("Brain Light the partner for your brain.")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Spacer()
                VStack {
                    ActionButton(title: "Logout", buttonColor: .red) {
                        userViewModel.showAlertTYpe = .logout
                        userViewModel.showAlert = true
                    }
                }
                .clipShapeModifier(paddingVertical: 0, paddingHorizontal: 0, cornerRadius: 12, paddingHorizontalTwo: 0, shadowRadius: 3)
            }
            .padding()
            .onAppear {
                userViewModel.fetchUser(with: userViewModel.user?.id ?? "")
            }
            .alert(isPresented: $userViewModel.showAlert) {
                withAnimation {
                    switch userViewModel.showAlertTYpe {
                    case .logout:
                        return Alert(
                            title: Text("Do you realy want to Logout?"),
                            primaryButton: .destructive(Text("Logout")) {
                                userViewModel.logout()
                            },
                            secondaryButton: .cancel()
                        )
                    case .passwordChange:
                        return Alert(
                            title: Text(""),
                            message: Text(userViewModel.alertMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
        }
    }
    
}
