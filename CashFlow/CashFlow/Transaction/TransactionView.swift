//
//  TransactionView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct TransactionView: View {
    @Environment(MainViewModel.self) var mainViewModel
    @State private var showAddTrans: Bool = false
    @State private var refreshTrigger = UUID()
    @State private var targetMonth: Int = 0
    
    private var monthTitle: String {
        mainViewModel.yearMonthTitle(value: targetMonth).yearMonthTitleString()
    }
    private var monthKey: String {
        mainViewModel.yearMonthTitle(value: targetMonth).yearMonthString()
    }
    private var monthlySummary: (income: Int, expense: Int, fixedExpense: Int) { MainViewModel.shared.monthlySummary[monthKey] ?? (0, 0, 0) }
    
    
    
    // MARK: - body
    var body: some View {
        @Bindable var mainViewModel = mainViewModel
        
        NavigationStack {
            VStack {
                // MARK: - 상단 탭
                VStack {
                    HStack {
                        Button {
                            targetMonth -= 1
                        } label: {
                            Image(systemName: "chevron.left")
                        }

                        Text(monthTitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Button {
                            targetMonth += 1
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        
                        Spacer()
                    }
                    .tint(.black)
                    .onChange(of: targetMonth) { _, _ in
                        mainViewModel.calculateMonthlyIncomeAndExpense(monthKey)
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
                    ForEach(MainViewModel.shared.transList[monthKey] ?? []) { transaction in
                        
                        TransactionCellView(transaction: transaction)
                            .id(refreshTrigger)
                            
                    }
                }
                .listStyle(.plain)
                
            } // End of Master Vstack
            .sheet(isPresented: $showAddTrans) {
                AddTransactionView()
            }
            .refreshable {
                refreshTrigger = UUID()
            }
            .onChange(of: MainViewModel.shared.transList) { oldValue, newValue in
                mainViewModel.saveTrans()
                mainViewModel.calculateMonthlyIncomeAndExpense(monthKey)
                refreshTrigger = UUID()
                print("on change of")
            }
        }
    }
}

#Preview {
    TransactionView()
        .environment(MainViewModel.shared)

}
