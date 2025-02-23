// TeamMember 모델

import Foundation

// TeamMember 모델
struct TeamMember: Identifiable, Codable {
    let id: UUID 
    var name: String
    var ename: String
    var position: String
    var intro: String
    var githubURL: String
    var blogURL: String
    
    init(
        id: UUID = UUID(),
        name: String,
        ename: String,
        position: String,
        intro: String,
        githubURL: String,
        blogURL: String
    ) {
        self.id = id
        self.name = name
        self.ename = ename
        self.position = position
        self.intro = intro
        self.githubURL = githubURL
        self.blogURL = blogURL
    }
}
