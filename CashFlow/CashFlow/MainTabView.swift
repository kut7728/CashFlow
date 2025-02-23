//
//  MainTabView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            
            TransactionView()
                .tabItem {
                    Image(systemName: "wallet.bifold")
                    Text("Account")
                }

            
            
            LandingView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environment(MainViewModel.shared)
}
