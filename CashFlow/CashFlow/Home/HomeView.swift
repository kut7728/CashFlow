//
//  HomeView.swift
//  CashFlow
//
//  Created by nelime on 2/15/25.
//

import SwiftUI

struct HomeView: View {
    //버튼 누를때 바뀌는 텍스트 부붐
    @State var btnText = "ᐯ"
    @State private var showDetail = false
    
    private var monthlySummary: (income: Int, expense: Int, fixedExpense: Int) { MainViewModel.shared.monthlySummary[Date().yearMonthString()] ?? (0, 0, 0) }
    
    
    var body: some View {
        VStack{
        //MARK:상단 탭
            VStack{
                HStack {//상단의 월,일 표시
                    Text(Date().toKoreanDateString().dropLast(4))
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                Spacer()
                    .frame(height: 20)
                
                HStack{ //상단에 항상 표시되는 수입, 지출 탭
                    HStack {
                        VStack{
                            Text("지출")
                            Text("\(monthlySummary.expense) 원")
                                .font(.title3)
                                .foregroundStyle(.red)
                        }
                        .frame(maxWidth: .infinity)
                        
                    }
                    Divider().padding(.horizontal, 30)
                        .frame(height: 100)
                        //.background(.blue)
                    
                    HStack {
                        VStack{
                            Text("수입")
                            Text("\(monthlySummary.income) 원")
                                 .font(.title3)
                                 .foregroundStyle(.blue)
                        }
                        .frame(maxWidth: .infinity)
                    }
                   
                }

            }//end of vstack
            .padding()
            .padding(.horizontal, 10)
            .frame(height: 150)
            .padding()
            
            //MARK:상세보기 부분
            VStack{
                Button(btnText){
                    self.showDetail.toggle()
                    
                    if showDetail {
                        btnText = "ᐱ"
                    }else {
                        btnText = "ᐯ"
                    }
                }.buttonStyle(.plain)
                
                if showDetail {
                    //상세보기 버튼을 눌렀을때 나오는 화면
                    HStack{
                        HStack {
                            VStack{
                                Text("총 고정 지출")
                                Text("\(monthlySummary.fixedExpense) 원")
                                    .font(.title3)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                        HStack {
                            VStack{
                                Text("포인트 총액")
                                Text("309,300 p")
                                    .font(.title3)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }
                        
                    }
                   
                    HStack{
                        HStack {
                            VStack{
                                Text("최근 소비 항목")
                                Text("89,300 원")
                                    .font(.title3)
                                Text("소니 인터렉티브 코리아")
                                    .font(.caption)
                                
                            }
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                           
                        }
                        HStack {
                            VStack{
                                Text("대출 잔여액")
                                Text("2,339,300 원")
                                    .font(.title3)
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            
                        }
                        
                    }
                }
            }
            Spacer()
            
           

            
            //상세 표시 보튼이랑 분석 화면 사이로 (그래프는 추후 예정)
            //총 고정 지출
            //포인트 총액
            //최근 소비 항목
            //대출 잔여액
            //평상시 숨겼다가 상세표시 버튼을 누를때 표시
            
            
        }
    }
}

#Preview {
    HomeView()
}
