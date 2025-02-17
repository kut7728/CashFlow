//
//  NewTransViewModel.swift
//  CashFlow
//
//  Created by nelime on 2/16/25.
//

import Foundation
import SwiftUI

@Observable
class NewTransViewModel {
    
    let id: UUID = UUID()
    
    var transactionName: String = ""
    var amount: String = ""
    var amountValue: Int { amount.NumberFormatter() }
    var date: Date = Date()
    var category: TransactionCategory = .expense
    
    
    
    
    // MARK: - 메서드
    ///
    func formatAmount(_ value: String) -> String {
        let formattedAmount: String
        let filtered = value.filter { "0123456789".contains($0) }
        
        if let number = Int(filtered) {
            formattedAmount = wonFormatter.string(from: NSNumber(value: number)) ?? "0원"
        } else {
            formattedAmount = "0원"
        }
        
        return formattedAmount
    }
    
    
    var wonFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.positiveSuffix = " 원"
        return formatter
    }
}
