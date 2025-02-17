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
    var monthlySummary: [String: (income: Int, expense: Int)] = [:]
    
    init() {
        loadTrans()
        calculateMonthlyIncomeAndExpense()
    }
    
    
    
    // MARK: - 항목 수정 파트
    func updateTransaction(_ transaction: Transaction, newTransaction: Transaction) {
        if let index = transList.firstIndex(where: { $0.id == transaction.id }) {
            transList[index] = newTransaction
        }
        self.transList.sort( by: { $0.date > $1.date } )
    }
    
    
    
    // MARK: - 달별 총액 계산 파트
    func calculateMonthlyIncomeAndExpense(){
        var monthlySummary: [String: (income: Int, expense: Int)] = [:]

        for transaction in self.transList {
            let monthKey = transaction.date.yearMonthString()  // "YYYY-MM" 변환

            if monthlySummary[monthKey] == nil {
                monthlySummary[monthKey] = (income: 0, expense: 0)  // 초기값 설정
            }

            // `amountValue`가 음수면 지출(expense), 양수면 수입(income)
            if transaction.category == .income {
                monthlySummary[monthKey]!.income += transaction.amountValue
            } else {
                monthlySummary[monthKey]!.expense += transaction.amountValue
            }
        }

        self.monthlySummary = monthlySummary  // 📌 { "2025-02": (income: 500000, expense: 320000), ... }
    }
    
    
    
    // MARK: - 파일 저장 파트
    private let fileName = "transactionList.json"
    
    func saveTrans() {
        // Document 디렉토리의 경로를 가져옴 (앱 전용 사용자 데이터 저장 경로)
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)  // 파일 경로 생성
        
        let encoder = JSONEncoder()  // JSON 인코더 생성
        if let data = try? encoder.encode(self.transList) {  // users 배열을 JSON 데이터로 변환
            do {
                try data.write(to: fileURL)  // 데이터를 파일에 저장
                print("데이터 저장 성공: \(fileURL)")  // 저장 성공 메시지 출력
            } catch {
                print("저장 실패: \(error)")  // 저장 실패 시 오류 메시지 출력
            }
        }
    }
    
    
    
    // json을 배열로 불러오는 메서드
    func loadTrans(){
        // Document 디렉토리의 경로와 저장된 파일의 경로 생성
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if let data = try? Data(contentsOf: fileURL) {  // 파일에서 데이터를 읽어옴
            let decoder = JSONDecoder()  // JSON 디코더 생성
            if let transactions = try? decoder.decode([Transaction].self, from: data) {  // JSON 데이터를 User 배열로 변환
                print("데이터 불러오기 성공")
                self.transList = transactions  // 변환된 User 배열 반환
                return
            }
        }
        print("데이터 불러오기 실패")
        self.transList = []  // 데이터 불러오기 실패 시 빈 배열 반환
    }
    
}
