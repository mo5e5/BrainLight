//
//  ZenQuoteRepository.swift
//  BrainLight
//
//  Created by Malte Oppermann on 13.06.24.
//

import Foundation

class ZenQuoteRepository {
    
    // MARK: - Functions
    
    func fetchQuote() async throws -> Quote {
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            throw HTTPError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        guard let quote = quotes.first else {
            throw HTTPError.noData
        }
        
        return quote
    }
}
