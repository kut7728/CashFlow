//
//  TransactionCellView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct TransactionCellView: View {
    var body: some View {
        HStack {
            Image(systemName: "pencil.circle.fill")
                .resizable()
                .frame(width: 36, height: 36)
                .foregroundStyle(.gray.opacity(0.7))
            
            Text("John Doe")
            
            Spacer()
            
            Text("+ 12,345 원")
                .font(.headline)
            
        }
        .frame(height: 55)
//        .border(.black)
    }
}

#Preview {
    TransactionCellView()
}
