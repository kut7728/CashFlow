//
//  AddTransactionView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct EditTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(MainViewModel.self) var mainViewModel
    
    @State var transaction: Transaction
    
    var body: some View {
        @Bindable var mainViewModel = mainViewModel
        
        VStack {
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text(transaction.name)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
            .font(.title3)
            
            
            
            DatePicker("날짜", selection: $transaction.date, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ko_KR"))
                .datePickerStyle(.graphical)
            
            Divider()
                .padding(.bottom, 30)
            
            VStack (spacing: 30) {
                HStack {
                    Text("분류")
                    Spacer()
                        .frame(width: 60)
                    Picker(selection: $transaction.category, label: Text("분류")) {
                        ForEach(TransactionCategory.allCases, id: \.self) {
                            Text($0.rawValue).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                HStack {
                    Text("내용")
                    Spacer()
                        .frame(width: 60)
                    TextField("입력해주세요", text: $transaction.name)
                    
                    Button {
                        transaction.name = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(.gray)
                    }
                    
                }
                
                HStack {
                    Text("액수")
                    Spacer()
                        .frame(width: 60)
                    TextField("입력해주세요", text: $transaction.amount)
                        .keyboardType(.numberPad)
                        .onSubmit {
                            transaction.amountValue = Int(transaction.amount)!
                            transaction.amount = NewTransViewModel.formatAmount(transaction.amount)
                        }
                    Button {
                        transaction.amount = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                            .tint(.gray)
                    }
                    
                    
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button {
                mainViewModel.updateTransaction(transaction, newTransaction: transaction)
                mainViewModel.saveTrans()
                dismiss()
            } label: {
                Text("저장")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.blue)
                    .tint(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            
            
        } // End of Master Vstack
        .padding(.horizontal, 20)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    AddTransactionView()
}
