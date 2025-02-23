// Tab 진입시 첫 화면
// Button을 활용해 ProfileView 페이지 진입

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationStack {
            ZStack {                 // ZStack은 뷰를 겹칠 수 있다.
                //배경 이미지
                Image("ProfileImage")
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                // 텍스트 작성
                VStack(alignment: .leading) {
                    Text("Meet the")
                        .font(.system(size: 73, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 47)
                        .padding(.top, 75)
                    Text("Makers")
                        .font(.system(size: 73, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.leading, 47)
                        .offset(y: -6)
                    
                    
                    // 버튼은 HStack으로 감싸서 중앙 정렬 처리
                    HStack {
                        Spacer()
                        NavigationLink(destination: ProfileMainView()) {    // NavigationLink 를 통해 다음페이지로 이동
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 68, height: 68)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                                
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 33, height: 33)
                                    .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    .offset(y: 34)
                }
                .offset(y: 36)
            }
            .navigationBarHidden(true)
        }
    }
}

// 미리보기 코드
struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
