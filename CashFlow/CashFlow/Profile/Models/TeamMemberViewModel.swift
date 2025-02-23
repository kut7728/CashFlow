import SwiftUI

// TeamMemberViewModel 모델
class TeamMemberViewModel: ObservableObject {
    @Published var teamMembers: [TeamMember] = []
    
    // 등록(Create)
    func addMember(_ member: TeamMember) {
        teamMembers.append(member)
    }
    
    // 업데이트(새로고침)
    func updatedMember(_ member: TeamMember) {
        if let index = teamMembers.firstIndex(where: { $0.id == member.id}) {
            teamMembers[index] = member
        }
    }
    // Delete (MemberDetailView에서 사용)
    func deletedMember(at offsets: IndexSet) {
        teamMembers.remove(atOffsets: offsets)
    }
}
