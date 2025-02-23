//
//  ContentView.swift
//  CashFlow
//
//  Created by nelime on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    @State var mainViewModel = MainViewModel.shared
    @State var showSplash: Bool = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashScreen()
                    .transition(.scale(scale: 1.5))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeOut(duration: 0.5))  {
                                showSplash = false
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeOut(duration: 0.5)) {
                            showSplash = false
                        }

                    }
            } else {
                MainTabView()
                    .environment(mainViewModel)
            }
            
        }
    }
}

struct SplashScreen: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(Color(red: 82/255.0, green: 113/255.0, blue: 255/255.0, opacity: 1))
            .ignoresSafeArea()
            .overlay {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
    }
}

#Preview {
    ContentView()
}
