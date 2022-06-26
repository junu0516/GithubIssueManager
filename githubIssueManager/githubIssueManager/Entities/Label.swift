import Foundation

struct Label: Decodable, TitleValuePossessible {
    
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
    }
}
