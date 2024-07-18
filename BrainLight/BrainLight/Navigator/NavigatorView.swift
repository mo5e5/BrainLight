//
//  NavigatorView.swift
//  BrainLight
//
//  Created by Malte Oppermann on 10.06.24.
//

import SwiftUI

struct NavigatorView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var selectedTab: Tab = .home
    
    // MARK: - Body
    
    var body: some View {
           VStack {
               selectedTab.view
               Spacer()
               HStack {
                   ForEach(Tab.allCases) { tab in
                       Button(action: {
                           selectedTab = tab
                       }) {
                           CustomTabButton(tab: tab, isSelected: selectedTab == tab)
                       }
                       .padding(.horizontal)
                   }
               }
               .background(.clear)
           }
           .onAppear {
               selectedTab = userViewModel.selectedTab
           }
       }
    
}
