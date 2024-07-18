//
//  BrainLightApp.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import SwiftUI
import Firebase

@main
struct BrainLightApp: App {
    
    // MARK: - Properties
    
    @StateObject private var userViewModel = UserViewModel()
    
    @State private var showSplashScreen: Bool = true
    
    // MARK: - Init
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
    }
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            if showSplashScreen {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplashScreen = false
                            }
                        }
                    }
            } else {
                if userViewModel.userIsLoggedIn {
                    NavigatorView()
                        .environmentObject(userViewModel)
                } else {
                    AuthenticationView()
                        .environmentObject(userViewModel)
                }
            }
        }
    }
    
}
