//
//  MainViewModel.swift
//  CashFlow
//
//  Created by nelime on 2/16/25.
//

import Foundation

@Observable
class MainViewModel {
    // 싱글톤 인스턴스 생성
    static let shared = MainViewModel()
    
    // 거래 항목을 모두 담는 리스트
    var transList: [Transaction] = []
    
    private init() {}
    
}
