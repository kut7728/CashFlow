//
//  TransactionCellView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct TransactionCellView: View {
    @State var transaction: Transaction
    
    private var transIcon: String {
        switch transaction.category {
        case .expense:
            "minus.circle.fill"
        case .income:
            "plus.circle.fill"
        case .fixedExpense:
            "pin.circle.fill"
        }
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: transIcon)
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundStyle(.gray.opacity(0.7))
            
            VStack (alignment: .leading) {
                Text(transaction.name)
                Text(transaction.date.toKoreanDateString())
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            
            Spacer()
            
            HStack {
                Text(transaction.category == .income ? "+" : "-")
                Text(transaction.amount)
            }
            .font(.headline)
            .foregroundStyle(transaction.category == .income ? .blue : .red)
            
        }
        .frame(height: 55)
    }
}

#Preview {
    TransactionCellView(transaction: Transaction.sampleData)
}
