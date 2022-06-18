import Foundation

struct LoginRepository {
    
    let networkManager: NetworkManagable
    
    init(networkManager: NetworkManagable = NetworkManager()) {
        self.networkManager = networkManager
    }
}
