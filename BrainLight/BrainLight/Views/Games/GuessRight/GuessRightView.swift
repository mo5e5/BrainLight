//
//  GuessRightView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 03.07.24.
//

import SwiftUI

struct GuessRightView: View {
    
    // MARK: - Properties
    
    @StateObject private var guessRightViewModel = GuessRightViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            if guessRightViewModel.questions.isEmpty {
                Text("Loading Questions...")
                    .font(.title)
                    .padding()
            } else {
                Text(guessRightViewModel.questions[guessRightViewModel.currentQuestionIndex].question)
                    .font(.title)
                    .padding()
                
                if let imageName = guessRightViewModel.questions[guessRightViewModel.currentQuestionIndex].image {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 12))                       
                        .frame(width: 250, height: 250)
                        .padding()
                }
                
                ForEach(0..<4) { index in
                    Button(action: {
                        guessRightViewModel.answerSelected(index)
                    }) {
                        Text(guessRightViewModel.answerText(for: index))
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(5)
                }
            }
        }
        .alert(isPresented: $guessRightViewModel.showAlert) {
            Alert(
                title: Text(guessRightViewModel.alertTitle),
                message: Text(guessRightViewModel.alertMessage),
                dismissButton: .default(Text("Next")) {
                    guessRightViewModel.nextQuestion()
                }
            )
        }
        .onChange(of: guessRightViewModel.isQuizCompleted) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
}


#Preview {
    GuessRightView()
}
