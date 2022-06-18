import Foundation

final class DeepLinkRouter {
    
    private weak var appCoordinator: AppCoordinator?
    var authCode = Observable<String>()
    let networkManager: NetworkManagable
    
    init?(appCoordinator: Coordinator?,
          networkManager: NetworkManagable = NetworkManager()) {
        guard let appCoordinator = appCoordinator as? AppCoordinator else { return nil }

        self.appCoordinator = appCoordinator
        self.networkManager = networkManager
        bind()
    }
    
    private func bind() {
        authCode.bind { [weak self] authCode in
            self?.requestAccessToken()
        }
    }
    
    private func requestAccessToken() {
        guard let authCode = authCode.value else { return }
        let authRequest = AuthRequest(code: authCode)
        
        guard let target = NetworkTarget(path: .githubAccessToken, method: .post, paramteterType: .json) else {
            return
        }
        networkManager.request(target: target, parameters: authRequest) { result in
            switch result {
            case .success(let data):
                Log.debug("success")
            case .failure(let error):
                Log.error("\(error.localizedDescription)")
            }
        }
    
    }
}
