// profile의 메인 페이지
// 우리 팀원의 명함을 보여줌
// CRUD의 Create의 기능을 담당("등록" 버튼)

import SwiftUI

struct PersonalCardView: View {
    let member: TeamMember
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // 명함 템플릿 이미지
            Image("PersonalCard")
                .resizable()
                .scaledToFit()
            
            // 이미지 위에 텍스트를 배치
            VStack(alignment: .leading, spacing: 8) {
                // 성명(name)
                Text(member.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                // 영문성명(ename)
                Text(member.ename)
                    .font(.title2)
                    .fontWeight(.bold)
                
                // 역할(position)
                Text(member.position)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                // 자기소개(intro)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // GitHub, Blog 링크
                if !member.githubURL.isEmpty, let gitURL = URL(string: member.githubURL) {
                    Link("GitHub", destination: gitURL)
                }
                if !member.blogURL.isEmpty, let blogURL = URL(string: member.blogURL) {
                    Link("Blog", destination: blogURL)
                }
            }
            .padding(16)
        }
    }
}

// 등록버튼과 전용시트
struct ProfileMainView: View {
    @StateObject private var viewModel: TeamMemberViewModel
    @State private var showAddSheet = false
    
    // 초기화 (Preview 에서 사용)
    init(viewModel: TeamMemberViewModel? = nil) {
        if let vm = viewModel {
            _viewModel = StateObject(wrappedValue: vm)
        } else {
            _viewModel = StateObject(wrappedValue: TeamMemberViewModel())
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showAddSheet = true
                    }) {
                        Text("합류하기")
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        
                    }
                    .padding()
                }
                
                // 명함 목록
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.teamMembers) { member in
                            PersonalCardView(member: member)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showAddSheet) {
                // 새 팀원 등록 시트
                AddMemberSheetView { newMember in
                    viewModel.addMember(newMember)
                }
            }
        }
    }
}

struct ProfileMainView_Previews: PreviewProvider {
    static var dummyVM: TeamMemberViewModel {
        let vm = TeamMemberViewModel()
        vm.teamMembers = [
            TeamMember(
                name: "김규철",
                ename: "KIM GYUCHEOL",
                position: "Developer of the Member page",
                intro: "Developer of the Credits Page",
                githubURL: "https://github.com/chillax96/IamaSwifty",
                blogURL: "https://velog.io/@chillax96/posts"
            ),
            TeamMember(
                name: "김규철",
                ename: "KIM GYUCHEOL",
                position: "Developer of the Member page",
                intro: "Developer of the Credits Page",
                githubURL: "https://github.com/chillax96/IamaSwifty",
                blogURL: "https://velog.io/@chillax96/posts"
            ),
            TeamMember(
                name: "김규철",
                ename: "KIM GYUCHEOL",
                position: "Developer of the Member page",
                intro: "Developer of the Credits Page",
                githubURL: "https://github.com/chillax96/IamaSwifty",
                blogURL: "https://velog.io/@chillax96/posts"
            )
        ]
        return vm
    }
    
    static var previews: some View {
        ProfileMainView(viewModel: dummyVM)
    }
}
