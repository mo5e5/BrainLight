//
//  SplashScreenView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 11.07.24.
//

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: - Body
    
    var body: some View {
           VStack {
               Image("logo")
                   .resizable()
                   .scaledToFit()
                   .frame(width: 150, height: 150)
               Text("Train Your Brain")
                   .font(.title)
                   .fontWeight(.bold)
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(.white)
           .edgesIgnoringSafeArea(.all)
       }
    
}

#Preview {
    SplashScreenView()
}
