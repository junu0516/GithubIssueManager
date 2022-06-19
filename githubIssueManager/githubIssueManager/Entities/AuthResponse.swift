import Foundation

struct AuthResponse {
    let accessToken: String
    let tokenType: String
    let scope: String
}

extension AuthResponse: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope = "scope"
    }
}
