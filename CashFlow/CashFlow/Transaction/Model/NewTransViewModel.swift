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
    var amount: String = "" // 원이 붙은 포맷된 문자열
    var amountValue: Int = 0 // 순수한 정수 값
    var date: Date = Date()
    var monthKey:String = ""
    var category: TransactionCategory = .expense
    
    
    // MARK: - 메서드
    func addTotransList() {
        self.monthKey = date.yearMonthString()
        
        // 해당 월의 저장소가 없다면 새로 추가
        if MainViewModel.shared.transList[monthKey] == nil {
            MainViewModel.shared.transList[monthKey] = []  // 초기값 설정
        }
        
        MainViewModel.shared.transList[monthKey]?.append(
            Transaction(id: id,
                        date: date,
                        monthKey: monthKey,
                        name: transactionName,
                        amount: amount,
                        amountValue: amountValue,
                        category: category)
        )
        
        MainViewModel.shared.transList[monthKey]?.sort( by: { $0.date > $1.date } )
    }
    
    /// 원과 쉼표가 붙은 포맷 문자열 출력하는 메서드
    static func formatAmount(_ value: String) -> String {
        let formattedAmount: String
        let filtered = value.filter { "0123456789".contains($0) }
        
        if let number = Int(filtered) {
            formattedAmount = wonFormatter.string(from: NSNumber(value: number)) ?? "0원"
        } else {
            formattedAmount = "0원"
        }
        
        return formattedAmount
    }
    
    
    static var wonFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.positiveSuffix = " 원"
        return formatter
    }
}
