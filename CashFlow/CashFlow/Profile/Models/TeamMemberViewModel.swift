import Foundation

// ✅ TeamMember 모델 정의 (JSON 필드 확장 가능)
struct TeamMember: Codable, Identifiable {
    var id: String = UUID().uuidString  // 기본값을 지정하여 자동으로 고유한 id 부여
    var name: String
    var ename: String
    var position: String
    var githubURL: String
    var blogURL: String
    var notionURL: String
    var birthYear: String
    var mbti: String
    var hobbies: String
    var workStyle: String
    var greeting: String
}

// ✅ TeamMemberViewModel 정의
class TeamMemberViewModel: ObservableObject {
    @Published var teamMembers: [TeamMember] = []
    private let fileName = "ourmember.json"

    init() {
        copyJSONIfNeeded() // ✅ 앱 실행 시 최신 JSON을 Documents로 복사
        loadTeamMembers()  // ✅ JSON 불러오기
    }

    // ✅ '번들'에서 'Documents'로 JSON 파일 복사
    private func copyJSONIfNeeded() {
        let fileManager = FileManager.default
        let destinationURL = getDocumentsDirectory().appendingPathComponent(fileName)

        // ✅ 기존 JSON 삭제 후 최신 JSON 복사
        if fileManager.fileExists(atPath: destinationURL.path) {
            do {
                try fileManager.removeItem(at: destinationURL)
                print("⚠️ 기존 JSON 삭제 완료")
            } catch {
                print("❌ 기존 JSON 삭제 실패: \(error)")
            }
        }

        // ✅ 번들에서 최신 JSON 복사
        if let bundleURL = Bundle.main.url(forResource: "ourmember", withExtension: "json") {
            do {
                try fileManager.copyItem(at: bundleURL, to: destinationURL)
                print("✔️ 최신 JSON 파일 복사 완료")
            } catch {
                print("❌ JSON 파일 복사 실패: \(error)")
            }
        }
    }

    // ✅ 'Documents' 폴더에서 JSON 불러오기
    func loadTeamMembers() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)

            // 🔍 현재 사용 중인 JSON 데이터를 콘솔에 출력
            let jsonString = String(data: data, encoding: .utf8) ?? "읽을 수 없음"
            print("🔍 현재 사용 중인 JSON 데이터:\n\(jsonString)")

            let members = try JSONDecoder().decode([TeamMember].self, from: data)
            DispatchQueue.main.async {
                self.teamMembers = members
            }
        } catch {
            print("❌ JSON 불러오기 실패: \(error)")
        }
    }

    // ✅ 팀원 삭제 기능 (JSON에서도 반영)
    func deleteMember(id: String) {
        if let index = teamMembers.firstIndex(where: { $0.id == id }) {
            teamMembers.remove(at: index)
            saveTeamMembers()
            print("🗑 팀원 삭제 완료: \(id)")
        } else {
            print("⚠️ 삭제 실패 - 해당 ID의 팀원이 없음: \(id)")
        }
    }

    // ✅ 새로운 팀원을 추가하고 JSON 저장
    func addMember(_ member: TeamMember) {
        teamMembers.append(member)
        saveTeamMembers()
        print("✅ 팀원 추가 완료: \(member.name)")
    }

    // ✅ 기존 팀원 정보를 업데이트하고 JSON 저장
    func updateMember(index: Int, member: TeamMember) {
        guard index >= 0 && index < teamMembers.count else {
            print("⚠️ updateMember() 실패 - 인덱스 범위 초과")
            return
        }
        teamMembers[index] = member
        saveTeamMembers()
        print("🔄 팀원 정보 업데이트 완료: \(member.name)")
    }

    // ✅ 'Documents' 폴더에 JSON 저장
    private func saveTeamMembers() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            let data = try JSONEncoder().encode(teamMembers)
            try data.write(to: fileURL)
            print("✔️ JSON 저장 완료")
        } catch {
            print("❌ JSON 저장 실패: \(error)")
        }
    }

    // ✅ 앱의 Documents 디렉토리 경로 가져오기
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
