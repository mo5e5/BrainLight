//
//  BraintisticsViewModel.swift
//  BrainLight
//
//  Created by Malte Oppermann on 17.06.24.
//

import Foundation

class BraintisticsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let firebaseManager = FirebaseManager.shared
    
    @Published var cookieClickerUserResults: [CookieClicker] = []
    @Published var cookieClickerGlobaleResults: [CookieClickerGlobal] = []
    
    @Published var guessRightUserResults: [GuessRightResult] = []
    @Published var guessRightGlobalUserResults: [GuessRightResultGlobal] = []
    
    // MARK: - Init
    
    init() {
        
    }
    
    // MARK: - Functions
    
    func fetchCookieClickerUserResults(userId: String) {
        firebaseManager.database.collection("cookieClickers").document(userId).collection("results").order(by: "amount", descending: true).limit(to: 10).getDocuments { querySnapshot, error in
            if let error {
                print("Error fetching results: \(error.localizedDescription).")
                return
            }
            
            guard let querySnapshot else {
                print("Snapshot does not exist.")
                return
            }
            
            self.cookieClickerUserResults = querySnapshot.documents.compactMap { document -> CookieClicker? in
                try? document.data(as: CookieClicker.self)
            }
        }
    }

    func fetchCookieClickerGlobaleResults() {
        firebaseManager.database.collection("cookieClickersGlobal").order(by: "amount", descending: true).limit(to: 50).getDocuments() { querySnapshot, error in
            if let error {
                print("Error fetching globale results: \(error.localizedDescription)")
                return
            }
            
            guard let querySnapshot else {
                print("Snapshot does not exist.")
                return
            }
            
            self.cookieClickerGlobaleResults = querySnapshot.documents.compactMap { document -> CookieClickerGlobal? in
                try? document.data(as: CookieClickerGlobal.self)
            }
        }
    }
    
    func fetchGuessRightUserResults(userId: String) {
            firebaseManager.database.collection("guessRights").document(userId).collection("results").order(by: "amount", descending: true).limit(to: 10).getDocuments { querySnapshot, error in
                if let error {
                    print("Error fetching GuessRight results: \(error.localizedDescription).")
                    return
                }
                
                guard let querySnapshot else {
                    print("Snapshot does not exist.")
                    return
                }
                
                self.guessRightUserResults = querySnapshot.documents.compactMap { document -> GuessRightResult? in
                    try? document.data(as: GuessRightResult.self)
                }
            }
        }
        
        func fetchGuessRightGlobalResults() {
            firebaseManager.database.collection("guessRightsGlobal").order(by: "amount", descending: true).limit(to: 50).getDocuments() { querySnapshot, error in
                if let error {
                    print("Error fetching GuessRight global results: \(error.localizedDescription)")
                    return
                }
                
                guard let querySnapshot else {
                    print("Snapshot does not exist.")
                    return
                }
                
                self.guessRightGlobalUserResults = querySnapshot.documents.compactMap { document -> GuessRightResultGlobal? in
                    try? document.data(as: GuessRightResultGlobal.self)
                }
            }
        }
    
}
