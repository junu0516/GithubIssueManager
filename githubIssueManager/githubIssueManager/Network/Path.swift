import Foundation

enum Path: CustomStringConvertible {
    case githubLogin(clientId: String)
    case githubAccessToken
    case githubIssues(owner: String, repo: String)
    
    var description: String {
        switch self {
        case .githubLogin(let clientId):
            return "https://github.com/login/oauth/authorize?client_id=\(clientId)&scope=user,repo"
        case .githubAccessToken:
            return "https://github.com/login/oauth/access_token"
        case .githubIssues(let owner, let repo):
            return "https://api.github.com/repos/\(owner)/\(repo)/issues"
        }
    }
}
