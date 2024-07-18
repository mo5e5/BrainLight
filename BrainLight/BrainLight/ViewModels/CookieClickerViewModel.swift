//
//  CookieClickerViewModel.swift
//  BrainLight
//
//  Created by Malte Oppermann on 20.06.24.
//

import Foundation

class CookieClickerViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let firebaseManager = FirebaseManager.shared
    
    @Published var cookieClicker: CookieClicker
    @Published var amount: Int  = 0
    
    // MARK: - Init
    
    init(cookieClicker: CookieClicker = CookieClicker(amount: 0, playedAt: .now)) {
        self.cookieClicker = cookieClicker
    }
    
    // MARK: - Functions
    
    func increaseCounter() {
        cookieClicker.amount += 1
        cookieClicker.playedAt = .now
    }
    
    func saveGame() {
        guard let userId = firebaseManager.userId else {
            print("User not logged in.")
            return
        }
        
        do {
            try firebaseManager.database.collection("cookieClickers").document(userId).collection("results").addDocument(from: cookieClicker)
        } catch let error {
            print("Error saving Game: \(error.localizedDescription).")
        }
    }
    
    func saveGlobalGame() {
        guard let userId = firebaseManager.userId else {
            print("User not logged in.")
            return
        }
        
        firebaseManager.database.collection("users").document(userId).getDocument { document, error in
            if let error = error {
                print("Fetching user failed: \(error.localizedDescription).")
                return
            }
            
            guard let document = document, document.exists else {
                print("User document does not exist.")
                return
            }
            
            do {
                let user = try document.data(as: FireUser.self)
                let newGlobalAmount = self.cookieClicker.amount
                self.checkAndUpdateGlobalGame(for: user, newAmount: newGlobalAmount)
            } catch let error {
                print("Error decoding user data: \(error.localizedDescription).")
            }
        }
    }
    
    private func checkAndUpdateGlobalGame(for user: FireUser, newAmount: Int) {
        let globaleGameDocRef = firebaseManager.database.collection("cookieClickersGlobal").document(user.id)
        
        globaleGameDocRef.getDocument { globalDocument, error in
            if let error = error {
                print("Fetching global game document failed: \(error.localizedDescription).")
                return
            }
            
            if let globalDocument = globalDocument, globalDocument.exists {
                do {
                    let existingGlobalGame = try globalDocument.data(as: CookieClickerGlobal.self)
                    if newAmount > existingGlobalGame.amount {
                        globaleGameDocRef.updateData(["amount": newAmount]) { error in
                            if let error = error {
                                print("Error updating global game: \(error.localizedDescription).")
                            } else {
                                print("Global game updated successfully.")
                            }
                        }
                    }
                } catch let error {
                    print("Error decoding global game data: \(error.localizedDescription).")
                }
            } else {
                let newGlobalGame = CookieClickerGlobal(userName: user.name, amount: newAmount)
                do {
                    try globaleGameDocRef.setData(from: newGlobalGame) { error in
                        if let error = error {
                            print("Error saving global game: \(error.localizedDescription).")
                        } else {
                            print("Global game saved successfully.")
                        }
                    }
                } catch let error {
                    print("Error saving global game: \(error.localizedDescription).")
                }
            }
        }
    }
    
}
