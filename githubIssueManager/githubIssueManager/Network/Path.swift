import Foundation

enum Path: CustomStringConvertible {
    case githubLogin
    
    var description: String {
        switch self {
        case .githubLogin:
            return ""
        }
    }
}
