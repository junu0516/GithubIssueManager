import Foundation

struct Assignee: Decodable, TitleValuePossessible {
    
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "login"
    }
}
