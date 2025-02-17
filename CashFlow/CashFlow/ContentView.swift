//
//  ContentView.swift
//  CashFlow
//
//  Created by nelime on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    @State var mainViewModel = MainViewModel()
    
    var body: some View {
        MainTabView()
            .environment(mainViewModel)
    }
}

#Preview {
    ContentView()
}
