import Foundation

struct IssueRequest {
    
    let title: String
    let body: String
    let labels: [Label]
    let assignees: [Assignee]
    let milestone: Milestone
}

extension IssueRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case title
        case body
        case labels = "label"
        case assignees = "assignees"
        case milestone = "milestone"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(labels.map { $0.title }, forKey: .labels)
        try container.encode(assignees.map { $0.title }, forKey: .assignees)
        try container.encode(milestone.number, forKey: .milestone)
    }
}
