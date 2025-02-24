// profile의 메인 페이지
// 우리 팀원의 명함을 보여줌
// CRUD의 Create(등록)와 Update(수정) 기능 담당

import SwiftUI

/// 개별 팀원 명함을 보여주는 뷰
struct PersonalCardView: View {
    @State private var showEditSheet = false // 수정 모달을 보여줄지 여부
    @State private var editedMember: TeamMember // 수정할 팀원의 데이터
    
    let member: TeamMember // 현재 표시할 팀원 정보
    var viewModel: TeamMemberViewModel // view 모델 추가
    var onEdit: (TeamMember) -> Void // 수정 완료 후 실행할 함수
    
    // 초기화 메서드
    init(member: TeamMember, viewModel: TeamMemberViewModel, onEdit: @escaping (TeamMember) -> Void) {
        self.member = member
        self.viewModel = viewModel
        self.onEdit = onEdit
        _editedMember = State(initialValue: member) // 초기값을 현재 팀원 정보로 설정
    }
    
    var body: some View {
        NavigationLink(destination: DetailView(member: member, viewModel: viewModel)) {
            ZStack(alignment: .topLeading) { // 명함을 ZStack으로 구성
                // 배경 이미지 (명함 템플릿)
                Image("PersonalCard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 340, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 33)) // 모서리를 둥글게
                    .overlay(
                        RoundedRectangle(cornerRadius: 33)
                            .stroke(Color.gray, lineWidth: 2) // 테두리 추가
                    )
                    .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 4) // 그림자 효과
                
                // 명함 내 텍스트 정보
                VStack(alignment: .leading, spacing: 0) {
                    Text(member.name) // 성명
                        .font(.system(size: 43, weight: .heavy))
                        .foregroundStyle(.black)
                    
                    Text(member.ename) // 영문 이름
                        .font(.system(size: 31, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(member.position) // 역할 (직책)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.secondary)
                    
                    // GitHub, Blog, Notion 링크 (아이콘으로 표시)
                    HStack(spacing: 16) {
                        if !member.githubURL.isEmpty, let gitURL = URL(string: member.githubURL) {
                            Link(destination: gitURL) {
                                Image("githubLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        if !member.blogURL.isEmpty, let blogURL = URL(string: member.blogURL) {
                            Link(destination: blogURL) {
                                Image(systemName: "book.pages")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.black)
                            }
                        }
                        if !member.notionURL.isEmpty, let notionURL = URL(string: member.notionURL) {
                            Link(destination: notionURL) {
                                Image("notionLogo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                    .padding(.top, 40)
                }
                .padding(.top, 250)
                .padding(.leading, 35)
            }
            
            // 오른쪽 상단에 연필(수정) 버튼 추가
            .overlay(
                Button(action: {
                    showEditSheet = true // 버튼 클릭 시 수정 모달 표시
                }) {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .padding()
                        .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 4)
                        .foregroundColor(.gray)
                },
                alignment: .topTrailing
            )
            
            .frame(width: 340, height:  600)
        }
            .sheet(isPresented: $showEditSheet) {
                EditMemberSheetView(member: $editedMember, onSave: {
                    onEdit(editedMember) // 수정 완료 시 실행
                })
            }
        }
    }
    
    // 수정 모달 (팀원 정보 수정)
    struct EditMemberSheetView: View {
        @Binding var member: TeamMember
        var onSave: () -> Void
        @Environment(\.presentationMode) private var presentationMode
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("이름")) {
                        TextField("이름", text: $member.name)
                    }
                    Section(header: Text("영문 이름")) {
                        TextField("영문 이름", text: $member.ename)
                    }
                    Section(header: Text("직책")) {
                        TextField("직책", text: $member.position)
                    }
                    Section(header: Text("GitHub URL")) {
                        TextField("GitHub", text: $member.githubURL)
                    }
                    Section(header: Text("블로그 URL")) {
                        TextField("블로그", text: $member.blogURL)
                    }
                    Section(header: Text("Notion URL")) {
                        TextField("Notion", text: $member.notionURL)
                    }
                }
                .navigationTitle("수정하기")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("취소") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("저장") {
                            onSave()
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
    
    // 메인 뷰 (팀원 목록 및 추가 버튼)
    struct ProfileMainView: View {
        @StateObject private var viewModel: TeamMemberViewModel
        @State private var showAddSheet = false
        
        // 초기화 (Preview용)
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.teamMembers.indices, id: \.self) { index in
                                PersonalCardView(member: viewModel.teamMembers[index],
                                viewModel: viewModel,
                                onEdit: { updatedMember in
                                    viewModel.updateMember(index: index, member: updatedMember)
                                })
                                .padding(.horizontal)
                            }
                            ZStack {
                                RoundedRectangle(cornerRadius: 33)
                                    .stroke(Color.gray, lineWidth: 2)
                                    .frame(width: 320, height: 585)
                                    .shadow(color: Color.black.opacity(0.4), radius: 3, x: 3, y: 4)
                                
                                Button(action: {
                                    showAddSheet = true
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                }
                                .frame(width: 50, height: 50)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }
                .navigationTitle("Team CashFlow")
                .sheet(isPresented: $showAddSheet) {
                    AddMemberSheetView { newMember in
                        viewModel.addMember(newMember)
                    }
                }
            }
        }
    }
    
    // Preview 제공
    struct ProfileMainView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = TeamMemberViewModel()
            
            // ✅ 프리뷰가 실행될 때 JSON을 강제로 다시 불러오기
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.loadTeamMembers()
            }
            
            return ProfileMainView(viewModel: viewModel)
        }
    }
