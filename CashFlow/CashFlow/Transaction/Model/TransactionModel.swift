//
//  TransactionModel.swift
//  CashFlow
//
//  Created by nelime on 2/16/25.
//

import Foundation

/// 지출 항목 구조체
struct Transaction: Identifiable, Codable {
    var id: UUID
    
    var date: Date
    var amount: Int
    var category: TransactionCategory
}

/// 항목 카테고리 enum
enum TransactionCategory: String, Codable, CaseIterable {
    case income = "수입"
    case expense = "지출"
    case fixedExpense = "고정지출"
}
