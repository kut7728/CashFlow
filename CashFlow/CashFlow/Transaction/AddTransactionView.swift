//
//  AddTransactionView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel = NewTransViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 30)
                
                HStack {
                    Text("항목 추가")
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

                
                
                DatePicker("날짜", selection: $viewModel.date, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "ko_KR"))
                    .datePickerStyle(.graphical)
                
                Divider()
                    .padding(.bottom, 30)
                
                VStack (spacing: 30) {
                    HStack {
                        Text("분류")
                        Spacer()
                            .frame(width: 60)
                        Picker(selection: $viewModel.category, label: Text("분류")) {
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
                        TextField("입력해주세요", text: $viewModel.transactionName)
                        
                        Button {
                            viewModel.transactionName = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .tint(.gray)
                        }
                        
                    }
                    
                    HStack {
                        Text("액수")
                        Spacer()
                            .frame(width: 60)
                        TextField("입력해주세요", text: $viewModel.amount)
                            .keyboardType(.numberPad)
                            .onSubmit {
                                viewModel.amountValue = Int(viewModel.amount)!
                                viewModel.amount = NewTransViewModel.formatAmount(viewModel.amount)
                            }
                        Button {
                            viewModel.amount = ""
                        } label: {
                            Image(systemName: "xmark.circle")
                                .tint(.gray)
                        }

                        
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button {
                    viewModel.addTotransList()
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
        }
    }
}

#Preview {
    AddTransactionView()
}
