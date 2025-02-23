// Sheet로 열리는 등록 폼
// TextField로 정보를 입력 -> "저장" 버튼을 통해 상위 뷰로 전달
// 닫을 때는 dismiss()를 사용
import SwiftUI

struct AddMemberSheetView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 입력값
    @State private var name: String = ""
    @State private var ename: String = ""
    @State private var position: String = ""
    @State private var github: String = ""
    @State private var blog: String = ""
    @State private var notion: String = ""
    @State private var birthYear: String = ""
    @State private var mbti: String = ""
    @State private var hobbies: String = ""
    @State private var workStyle: String = ""
    @State private var greeting: String = ""
    
    let onSave: (TeamMember) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("새 팀원 정보")) {
                    TextField("성명", text: $name)
                    TextField("영문성명", text: $ename)
                    TextField("역할", text: $position)
                    TextField("GitHub URL", text: $github)
                    TextField("Blog URL", text: $blog)
                    TextField("Notion URL", text: $notion)
                }
            }
            .navigationTitle("합류하기")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        let newmember = TeamMember(
                            name: name,
                            ename: ename,
                            position: position,
                            githubURL: github,
                            blogURL: blog,
                            notionURL: notion,
                            birthYear: birthYear,
                            mbti: mbti,
                            hobbies: hobbies,
                            workStyle: workStyle,
                            greeting: greeting
                        )
                        onSave(newmember)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
            }
        }
    }
}

