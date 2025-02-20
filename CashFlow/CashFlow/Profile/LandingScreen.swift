// DevelopersTab 진입시 첫 화면
// Button을 활용해 ProfileView 페이지 진입

import SwiftUI

struct LandingScreen: View {
    var body: some View {
        NavigationView {
            ZStack {            //ZStack은 뷰를 겹칠 수 있다.
            //배경 이미지 삽입
            Image("profileImage")
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            
            // 텍스트 작성
            VStack(alignment: .leading) {
                Text("Meet the")
                    .font(.system(size: 73, weight: .bold))
                    .offset(x: 33, y: 75)
                Text("Makers")
                    .font(.system(size: 73, weight: .bold))
                    .offset(x: 33, y: 70)
                
                // 버튼은 HStack으로 감싸서 중앙 정렬 처리
                HStack {
                    Spacer()
                    NavigationLink(destination: ProfileView()) {
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 68, height: 68)
                                .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
                        
                        // 화살표 아이콘 추가
                        Image(systemName: "arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 33, height: 33)
                            .foregroundColor(.black)
                    }
                        .offset(x: 0, y: 100)
                }
                    Spacer()
            }
                .padding(.bottom, 30)
            }
            .padding()
            }
        .navigationBarHidden(true)
        }
    }
}
struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
            .padding()
    }
}

// 미리보기 코드
struct DevelopersView_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
