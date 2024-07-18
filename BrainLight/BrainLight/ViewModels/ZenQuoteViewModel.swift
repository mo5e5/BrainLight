//
//  ZenQuoteViewModel.swift
//  BrainLight
//
//  Created by Malte Oppermann on 13.06.24.
//

import Foundation

@MainActor
class ZenQuoteViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var quote: Quote = Quote(q: "", a: "")
    
    private let zenQuoteRepository = ZenQuoteRepository()
    
    // MARK: - Init
    
    init() {
       fetchData()
    }
    
    // MARK: - Fuctions
    
    func fetchData() {
        Task {
            do {
                self.quote = try await zenQuoteRepository.fetchQuote()
            } catch {
                print("Request failed with error: \(error.localizedDescription).")
            }
        }
    }
    
}
