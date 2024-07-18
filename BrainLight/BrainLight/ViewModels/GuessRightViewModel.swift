//
//  GuessRightViewModel.swift
//  BrainLight
//
//  Created by Malte Oppermann on 03.07.24.
//

import Foundation

class GuessRightViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let firebaseManager = FirebaseManager.shared
    
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var showAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""
    @Published var correctAnswersCount: Int = 0
    @Published var totalCorrectAnswersCount: Int = 0
    @Published var totalGamesPlayed: Int = 0
    @Published var isQuizCompleted: Bool = false
    
    var questions: [GuessRight] = []
    
    // MARK: - Init
    
    init() {
        fetchQuestions()
    }
    
    
    // MARK: - Functions
    
    func fetchQuestions() {
        self.questions = guessRightQuestions.shuffled().prefix(10).map {  $0 }
    }
    
    func answerSelected(_ index: Int) {
        selectedAnswerIndex = index
        let correctAnswerIndex = questions[currentQuestionIndex].correctAnswer
        if index == correctAnswerIndex {
            alertTitle = "Right!"
            alertMessage = "The right answer is \(answerText(for: correctAnswerIndex))."
            correctAnswersCount += 1
        } else {
            alertTitle = "Wrong!"
            alertMessage = "The right answer is \(answerText(for: correctAnswerIndex))."
        }
        showAlert = true
    }
    
    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            saveGame {
                self.fetchGlobalStatistics { globalStatistics in
                    let newGlobalAmount = globalStatistics.amount + self.correctAnswersCount
                    let newGamesPlayed = globalStatistics.gamesPlayed + 1
                    self.saveGlobalGame(newAmount: newGlobalAmount, gamesPlayed: newGamesPlayed) {
                        self.totalCorrectAnswersCount = newGlobalAmount
                        self.totalGamesPlayed = newGamesPlayed
                        self.isQuizCompleted = true
                    }
                }
            }
        }
        selectedAnswerIndex = nil
    }
    
    func answerText(for index: Int) -> String {
        let question = questions[currentQuestionIndex]
        switch index {
        case 0:
            return question.answerOne
        case 1:
            return question.answerTwo
        case 2:
            return question.answerThree
        case 3:
            return question.answerFour
        default:
            return ""
        }
    }
    
    func saveGame(completion: @escaping () -> Void) {
        guard let userId = firebaseManager.userId else {
            print("User not logged in.")
            return
        }
        
        let result = GuessRightResult(amount: correctAnswersCount, playedAt: Date())
        
        do {
            try firebaseManager.database.collection("guessRights").document(userId).collection("results").addDocument(from: result) { error in
                if let error = error {
                    print("Error saving game: \(error.localizedDescription).")
                } else {
                    completion()
                }
            }
        } catch let error {
            print("Error saving game: \(error.localizedDescription).")
        }
    }
    
    func fetchGlobalStatistics(completion: @escaping (GuessRightResultGlobal) -> Void) {
            guard let userId = firebaseManager.userId else {
                print("User not logged in.")
                completion(GuessRightResultGlobal(userName: "", amount: 0, gamesPlayed: 0))
                return
            }
            
            let globalGameDocRef = firebaseManager.database.collection("guessRightsGlobal").document(userId)
            
            globalGameDocRef.getDocument { globalDocument, error in
                if let error = error {
                    print("Fetching global game document failed: \(error.localizedDescription).")
                    completion(GuessRightResultGlobal(userName: "", amount: 0, gamesPlayed: 0))
                    return
                }
                
                if let globalDocument = globalDocument, globalDocument.exists {
                    do {
                        let existingGlobalGame = try globalDocument.data(as: GuessRightResultGlobal.self)
                        completion(existingGlobalGame)
                    } catch let error {
                        print("Error decoding global game data: \(error.localizedDescription).")
                        completion(GuessRightResultGlobal(userName: "", amount: 0, gamesPlayed: 0))
                    }
                } else {
                    completion(GuessRightResultGlobal(userName: "", amount: 0, gamesPlayed: 0))
                }
            }
        }
    
    func saveGlobalGame(newAmount: Int, gamesPlayed: Int, completion: @escaping () -> Void) {
            guard let userId = firebaseManager.userId else {
                print("User not logged in.")
                return
            }
            
            let globalGameDocRef = firebaseManager.database.collection("guessRightsGlobal").document(userId)
            
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
                    let updatedGlobalGame = GuessRightResultGlobal(userName: user.name, amount: newAmount, gamesPlayed: gamesPlayed)
                    try globalGameDocRef.setData(from: updatedGlobalGame) { error in
                        if let error = error {
                            print("Error saving global game: \(error.localizedDescription).")
                        } else {
                            print("Global game saved successfully.")
                            completion()
                        }
                    }
                } catch let error {
                    print("Error decoding user data: \(error.localizedDescription).")
                }
            }
        }
    
    private func createGlobalResult(for userId: String, newAmount: Int, completion: @escaping () -> Void) {
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
                let newGlobalGame = GuessRightResultGlobal(userName: user.name, amount: newAmount, gamesPlayed: 1)
                try self.firebaseManager.database.collection("guessRightsGlobal").document(user.id).setData(from: newGlobalGame) { error in
                    if let error = error {
                        print("Error saving global game: \(error.localizedDescription).")
                    } else {
                        print("Global game saved successfully.")
                        completion()
                    }
                }
            } catch let error {
                print("Error decoding user data: \(error.localizedDescription).")
            }
        }
    }
    
}
