import Foundation

enum Path: CustomStringConvertible {
    case githubLogin(clientId: String)
    
    var description: String {
        switch self {
        case .githubLogin(let clientId):
            return "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=user,repo"
        }
    }
}
