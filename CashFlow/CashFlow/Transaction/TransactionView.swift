//
//  TransactionView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct TransactionView: View {
    @State private var showAddTrans: Bool = false
    @State private var viewModel = MainViewModel()
    
    private var monthlySummary: (income: Int, expense: Int) { MainViewModel.shared.monthlySummary["2025-02"] ?? (0, 0) }
    
    // MARK: - body
    var body: some View {
        
        NavigationStack {
            VStack {
                // MARK: - 상단 탭
                VStack {
                    HStack {
                        Text("2025년 2월")
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
                                Text("\(monthlySummary.expense) 원")
                                    .font(.title3)
                                    .foregroundStyle(.red)
                            }
                            
                            HStack {
                                Text("수입")
                                Text("\(monthlySummary.income) 원")
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
                    ForEach(viewModel.transList) { transaction in
                        
                        TransactionCellView(transaction: transaction)
                            .swipeActions(allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    viewModel.transList.removeAll { $0.id == transaction.id }
                                } label: {
                                    Label("삭제", systemImage: "trash")
                                    
                                }
                            }
                            .background {
                                NavigationLink {
                                    EditTransactionView(transaction: transaction)
                                } label: {
                                    EmptyView()
                                }


                            }
                    }
                }
                .listStyle(.plain)
                
            } // End of Master Vstack
            .sheet(isPresented: $showAddTrans) {
                AddTransactionView()
            }
            .onChange(of: viewModel.transList) { _, _ in
                viewModel.saveTrans()
                viewModel.calculateMonthlyIncomeAndExpense()
            }
        }
    }
}

#Preview {
    TransactionView()
}
