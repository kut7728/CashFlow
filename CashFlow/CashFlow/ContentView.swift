//
//  ContentView.swift
//  CashFlow
//
//  Created by nelime on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        MainTabView()
            .environment(MainViewModel.shared)
    }
}

#Preview {
    ContentView()
}
