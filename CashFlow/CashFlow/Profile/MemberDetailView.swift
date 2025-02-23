import SwiftUI

struct MemberDetailView: View {
    @State var member: TeamMember
    let onSave: (TeamMember) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // 명함 템플릿 이미지
                Image("PersonalCard")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding(.top, 20)
                
                // 편집용 텍스트필드
                TextField("성명", text: $member.name)
                    .textFieldStyle(.roundedBorder)
                TextField("개발기능", text: $member.position)
                    .textFieldStyle(.roundedBorder)
                TextField("간단소개", text: $member.intro)
                    .textFieldStyle(.roundedBorder)
                TextField("GitHub URL", text: $member.githubURL)
                    .textFieldStyle(.roundedBorder)
                TextField("Blog URL", text: $member.blogURL)
                    .textFieldStyle(.roundedBorder)
                
                // 저장 버튼: 수정 내용을 반영
                Button("저장") {
                    onSave(member)
                }
                .padding()
                .frame(minWidth: .infinity)
                .background(.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(member.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MemberDetailView_previews: PreviewProvider {
    static var previews: some View {
        MemberDetailView(
            member: TeamMember(
                name: "아무개",
                ename: "emg",
                position: "Developer of the Member Page",
                intro: "나를 한문장으로 표현해보세요",
                githubURL: "깃허브 주소",
                blogURL: "블로그 주소"
                )
        ) { updatedMember in
            // Previews에서는 onSave 처리를 생략한다.
        }
    }
}
