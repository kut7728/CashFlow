//
//  TransactionView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct TransactionView: View {
    @State private var showAddTrans: Bool = false
    @Environment(MainViewModel.self) var mainViewModel
    
    // MARK: - body
    var body: some View {
        @Bindable var viewModel = mainViewModel
        
        VStack {
            // MARK: - 상단 탭
            VStack {
                HStack {
                    Text("2025년 1월")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 20)
                
                HStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("지출")
                            Text("1,339,300 원")
                                .font(.title3)
                                .foregroundStyle(.red)
                        }
                        
                        HStack {
                            Text("수입")
                            Text("3,339,300 원")
                                .font(.title3)
                                .foregroundStyle(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        print("adding account")
                        showAddTrans = true
                    } label: {
                        Text("항목 추가")
                            .frame(maxHeight: .infinity)
                            .frame(width: 80)
                            .background(.blue)
                            .tint(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                }
                
                
            } // End of Header Tab
            .padding()
            .padding(.horizontal, 10)
            .frame(height: 130)
            
            List {
                ForEach(1..<20) { _ in
                    TransactionCellView()
                }
            }
            .listStyle(.plain)
            
        } // End of Master Vstack
        .sheet(isPresented: $showAddTrans) {
            AddTransactionView()
        }
        
    }
}

#Preview {
    TransactionView()
        .environment(MainViewModel())
}
