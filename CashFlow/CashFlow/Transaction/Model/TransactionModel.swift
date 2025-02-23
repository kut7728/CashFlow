//
//  TransactionModel.swift
//  CashFlow
//
//  Created by nelime on 2/16/25.
//

import Foundation

/// 지출 항목 구조체
struct Transaction: Identifiable, Codable, Equatable {
    var id: UUID
    
    var date: Date
    var monthKey: String
    var name: String
    var amount: String
    var amountValue: Int
    var category: TransactionCategory
}

/// 항목 카테고리 enum
enum TransactionCategory: String, Codable, CaseIterable {
    case income = "수입"
    case expense = "지출"
    case fixedExpense = "고정지출"
}

extension Transaction {
    static var sampleData = Transaction(id: UUID(), date: Date(), monthKey: "2025-02", name: "sample", amount: "123,333,222 원", amountValue: 123333222, category: .expense)
        
}
