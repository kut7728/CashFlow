import SwiftUI

struct DetailView: View {
    let member: TeamMember
    @ObservedObject var viewModel: TeamMemberViewModel
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var showDeleteAlert = false // ✅ 삭제 확인 Alert 상태 변수 추가
    
    var body: some View {
        ScrollView {
            VStack(spacing: 3) {
                
                // 📝 이름 및 직책 정보
                Text(member.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(member.ename)
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(member.position)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                // 📝 추가 정보 (출생년도, MBTI, 취미, 협업 스타일)
                VStack(alignment: .leading, spacing: 10) {
                    Text(member.greeting)
                        .font(.title3.bold())
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                    
                    Text("🎂 출생년도")
                        .font(.headline)
                    Text(member.birthYear)
                        .font(.body)
                    
                    Text("🧠 MBTI")
                        .font(.headline)
                    Text(member.mbti)
                        .font(.body)
                    
                    Text("🎨 취미 & 좋아하는 것")
                        .font(.headline)
                    Text(member.hobbies)
                        .font(.body)
                        .padding(.bottom, 5)
                    
                    Text("🤝 협업 스타일")
                        .font(.headline)
                    Text(member.workStyle)
                        .font(.body)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                
                // 📝 GitHub, 블로그, 노션 링크 (아이콘 & 가로 정렬)
                HStack(spacing: 30) { // ✅ 아이콘을 가로 정렬
                    if !member.githubURL.isEmpty, let gitURL = URL(string: member.githubURL) {
                        Link(destination: gitURL) {
                            Image("githubLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                        }
                    }
                    if !member.blogURL.isEmpty, let blogURL = URL(string: member.blogURL) {
                        Link(destination: blogURL) {
                            Image(systemName: "book.pages") // 📖 블로그 아이콘
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                    }
                    if !member.notionURL.isEmpty, let notionURL = URL(string: member.notionURL) {
                        Link(destination: notionURL) {
                            Image("notionLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)

                        }
                    }
                }
                .padding(.vertical, 10)
                
                Spacer()
                
                // 🗑 삭제 버튼 (Alert 추가)
                Button(action: {
                    showDeleteAlert = true // ✅ 삭제 버튼 클릭 시 Alert 표시
                }) {
                    Text("삭제하기")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 45)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .alert(isPresented: $showDeleteAlert) { // ✅ Alert 설정
                    Alert(
                        title: Text("⚠️ 삭제 확인"),
                        message: Text("정말 삭제하시겠습니까? 우리팀을 떠나지 마세요🥺"),
                        primaryButton: .destructive(Text("삭제")) {
                            viewModel.deleteMember(id: member.id)
                            presentationMode.wrappedValue.dismiss()
                        },
                        secondaryButton: .cancel(Text("취소"))
                    )
                }
            }
            .padding(.vertical, 20)
        }
        .navigationTitle("👤 팀원 정보")
    }
}

// ✅ SwiftUI Preview 추가 (JSON 데이터 불러오기)
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // ✅ JSON 파일에서 데이터를 직접 불러오는 함수
        func loadSampleMember() -> TeamMember {
            guard let url = Bundle.main.url(forResource: "ourmember", withExtension: "json") else {
                fatalError("❌ ourmember.json 파일을 찾을 수 없습니다.")
            }
            
            do {
                let data = try Data(contentsOf: url)
                let members = try JSONDecoder().decode([TeamMember].self, from: data)
                
                // ✅ 첫 번째 멤버를 반환 (데이터가 있으면)
                if let firstMember = members.first {
                    return firstMember
                } else {
                    fatalError("❌ JSON 파일이 비어 있습니다.")
                }
            } catch {
                fatalError("❌ JSON 디코딩 실패: \(error)")
            }
        }
        
        let viewModel = TeamMemberViewModel() // ✅ ViewModel 생성
        let sampleMember = loadSampleMember() // ✅ JSON 데이터 불러오기
        
        return NavigationView {
            DetailView(member: sampleMember, viewModel: viewModel)
        }
    }
}
