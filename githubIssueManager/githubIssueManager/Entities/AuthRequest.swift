import Foundation

struct AuthRequest {
    let clientId: String
    let clientSecret: String
    let code: String
    
    init() {
        self.clientId = Bundle.main.githubClientId
        self.clientSecret = Bundle.main.githubSecret
        self.code = ""
    }
    
    init(code: String) {
        self.clientId = Bundle.main.githubClientId
        self.clientSecret = Bundle.main.githubSecret
        self.code = code
    }
}

extension AuthRequest: Encodable {
    
    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case code = "code"
    }
}
