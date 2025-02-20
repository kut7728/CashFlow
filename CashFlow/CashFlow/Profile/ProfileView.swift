// credits 첫 페이지
// button을 활용해 다음 페이지로 넘어가는 기능

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile View")
                .font(.largeTitle)
                .padding()
            
            // 다음 페이지로 넘어가는 버튼 (NavigationLink)
            NavigationLink(destination: NextPageView()) {
                Text("Next Page")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NextPageView: View {
    var body: some View {
        Text("Next Page")
            .font(.largeTitle)
            .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
