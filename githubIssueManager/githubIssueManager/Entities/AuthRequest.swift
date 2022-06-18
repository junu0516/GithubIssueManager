import Foundation

struct AuthRequest {
     let clientId: String
    
    init() {
        self.clientId = Bundle.main.githubClientId
    }
}

extension AuthRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
    }
}
