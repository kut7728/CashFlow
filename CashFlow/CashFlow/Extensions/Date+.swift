//
//  Date+.swift
//  CashFlow
//
//  Created by nelime on 2/17/25.
//

import Foundation

extension Date {
    
    func toKoreanDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: self)
    }
}

extension Date {
    
    func yearMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"  // "2025-02"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}

extension Date {
    
    func yearMonthTitleString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"  // "2025-02"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
