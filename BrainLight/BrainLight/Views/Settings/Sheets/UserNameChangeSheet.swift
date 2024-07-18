//
//  ChangeUserNameSheet.swift
//  BrainLight
//
//  Created by Malte Oppermann on 17.06.24.
//

import SwiftUI

struct UserNameChangeSheet: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State private var newUserName: String = ""
    
    @Binding var userNameSheet: Bool
    
    // MARK: - Body

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                    TextField("New Name", text: $newUserName)
                        .textInputAutocapitalization(.never)
                ActionButton(title: "Save", buttonColor: .cyan) {
                        if let userId = userViewModel.user?.id {
                            userViewModel.changeUserName(with: userId, name: newUserName)
                        }
                        newUserName = ""
                        userNameSheet = false
                    }
            }
            .clipShapeModifier(paddingVertical: 12, paddingHorizontal: 12, cornerRadius: 12, paddingHorizontalTwo: 18, shadowRadius: 10)
            .navigationTitle("Change your Name")
            .navigationBarItems(trailing: Button("cancel") {
                userNameSheet = false
            })
        }
    }
    
}

#Preview {
    UserNameChangeSheet(userNameSheet: .constant(false))
        .environmentObject(UserViewModel())
}
