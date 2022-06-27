import Foundation

struct Label: Decodable, TitleValuePossessible {
    
    let title: String
    let description: String
    let color: String
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case description
        case color
    }
}
