//
//  UserViewModel.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import Foundation

class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let firebaseManager = FirebaseManager.shared
    
    @Published var user: FireUser?
    
    @Published var mode: AuthenticationMode = .login
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var showAlertTYpe: SettingsAlertType = .logout
    @Published var alertMessage: String = ""
    @Published var selectedTab: Tab = .home
    
    var disableAuthentication: Bool {
        email.isEmpty || password.isEmpty || (mode == .register && name.isEmpty)
    }
    
    var userIsLoggedIn: Bool {
        user != nil
    }
    
    var userEmail: String {
        user?.email ?? ""
    }
    
    // MARK: - Init
    
    init() {
        checkAuth()
    }
    
    // MARK: - Functions
    
    func switchAuthenticationMode() {
        mode = mode == .login ? .register : .login
    }
    
    func auhenticate() {
        switch mode {
        case .login:
            login()
        case .register:
            register()
        }
    }
    
    private func checkAuth() {
        guard let currentUser = firebaseManager.auth.currentUser else {
            print("No User logged in.")
            return
        }
        
        self.fetchUser(with: currentUser.uid)
    }
    
    func login() {
        firebaseManager.auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                self.alertMessage = "Login failed: E-Mail or Password false!"
                self.showAlert = true
                
                print("Login failed: \(error.localizedDescription).")
                return
            }
            
            guard let authResult, let email = authResult.user.email else { return }
            print("User with email \(email) is logged in with id \(authResult.user.uid).")
            
            self.fetchUser(with: authResult.user.uid)
            self.selectedTab = .home
            self.resetUserInput()
        }
    }
    
    func register() {
        firebaseManager.auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                self.alertMessage = "Registration failed \(error.localizedDescription)."
                self.showAlert = true
                
                print("Registration failed: \(error.localizedDescription).")
                return
            }
            
            guard let authResult = authResult else {
                print("Auth result is nil.")
                return
            }
            
            guard let email = authResult.user.email else {
                print("Email result is nil.")
                return
            }
            
            print("User with email \(email) is registerd with id \(authResult.user.uid).")
            
            self.createUser(with: authResult.user.uid, name: self.name, email: email)
            self.fetchUser(with: authResult.user.uid)
            self.selectedTab = .home
            self.resetUserInput()
        }
    }
    
    func logout() {
        do {
            try firebaseManager.auth.signOut()
            self.user = nil
            
            print("User has been logged out.")
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        
        self.selectedTab = .home
    }
    
}

// MARK: - Data

extension UserViewModel {
    
    private func createUser(with id: String, name: String, email: String) {
        let user = FireUser(id: id, name: name, email: email , registeredAt: Date())
        
        do {
            try firebaseManager.database.collection("users").document(id).setData(from: user)
        } catch let error {
            print("Error saving user: \(error.localizedDescription).")
        }
    }
    
    func fetchUser(with id: String) {
        firebaseManager.database.collection("users").document(id).getDocument { document, error in
            if let error {
                print("Fetching user failed: \(error.localizedDescription).")
                return
            }
            
            guard let document else {
                print("Document does not exist.")
                return
            }
            
            do {
                let user = try document.data(as: FireUser.self)
                self.user = user
            } catch {
                print("Document is not a user: \(error.localizedDescription).")
            }
        }
    }
    
}

// MARK: - Change Data

extension UserViewModel {
    
    func changeUserName(with id: String, name: String) {
        let user = firebaseManager.database.collection("users").document(id)
        
        user.updateData([
            "name": name
        ]) { error in
            if let error = error {
                print("Error changing UserName: \(error.localizedDescription)")
            } else {
                print("UserName successfully updated")
            }
        }
        
        fetchUser(with: id)
    }
    
    func changePassword(newPassword: String) {
        guard let user = firebaseManager.auth.currentUser else {
            print("No user is logged in")
            return
        }
        
        user.updatePassword(to: newPassword) { error in
            if let error = error {
                print("Error changing password: \(error.localizedDescription).")
                self.showAlertTYpe = .passwordChange
                self.alertMessage = "Error changing password."
                self.showAlert = true
            } else {
                print("Password successfully changed.")
                self.showAlertTYpe = .passwordChange
                self.alertMessage = "Password succssesfully changed."
                self.showAlert = true
            }
        }
    }
    
    private func resetUserInput() {
        name = ""
        email = ""
        password = ""
    }
    
}
