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
    @State private var intro: String = ""
    @State private var github: String = ""
    @State private var blog: String = ""
    
    let onSave: (TeamMember) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("새 팀원 정보")) {
                    TextField("성명", text: $name)
                    TextField("영문성명", text: $ename)
                    TextField("역할", text: $position)
                    TextField("간단소개", text: $intro)
                    TextField("GitHub URL", text: $github)
                    TextField("Blog URL", text: $blog)
                }
            }
            .navigationTitle("Add Member")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        let newmember = TeamMember(
                            name: name,
                            ename: ename,
                            position: position,
                            intro: intro,
                            githubURL: github,
                            blogURL: blog
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

