//
//  AuthenticationMode.swift
//  BrainLight
//
//  Created by Malte Oppermann on 05.06.24.
//

import Foundation

enum AuthenticationMode {
    case login, register
   
    var title: String {
        switch self {
        case .login: return "Sign In"
        case .register: return "Sign Up"
        }
    }
    
    var alternativeTitle: String {
        switch self {
        case .login: return "Don´t have account?"
        case .register: return "Allready have account?"
        }
    }
    
    var coloredPart: String {
        switch self {
        case .login: return "Sign Up now  →"
        case .register: return "Sign In here →"
        }
    }
}
