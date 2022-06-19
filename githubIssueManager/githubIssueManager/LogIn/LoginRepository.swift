import Foundation

struct LoginRepository {
    
    let networkManager: NetworkManagable
    
    init(networkManager: NetworkManagable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAuthenticationRequestUrl() -> URL? {
        let authRequest = AuthRequest()
        let urlString = Path.githubLogin(clientId: authRequest.clientId).description

        return URL(string: urlString)
    }
}
