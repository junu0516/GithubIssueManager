import Foundation

struct Issue: Decodable {
    
    let title: String
    let body: String?
    let milestone: Milestone?
    
    enum CodingKeys: String, CodingKey {
        case title, body, milestone
    }
}

