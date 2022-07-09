import Foundation

final class DeepLinkRouter {
    
    private weak var appCoordinator: AppCoordinator?
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible
    
    var authCode = Observable<String>()
    var authToken = Observable<String>()
    
    init?(appCoordinator: Coordinator?,
          networkManager: NetworkManagable = NetworkManager(),
          objectConverter: ObjectConvertible = ObjectConverter()) {
        self.appCoordinator = appCoordinator as? AppCoordinator
        self.networkManager = networkManager
        self.objectConverter = objectConverter
        
        bind()
    }
    
    private func bind() {
        authCode.bind { [weak self] authCode in
            self?.requestAccessToken()
        }
        
        authToken.bind { [weak self] authToken in
            self?.appCoordinator?.accessToken = authToken
            self?.appCoordinator?.moveToMainViewController()
        }
    }
    
    private func requestAccessToken() {
        guard let authCode = authCode.value else { return }
        let authRequest = AuthRequest(code: authCode)
        let target = NetworkTarget(path: .githubAccessToken,
                                   method: .post,
                                   paramteterType: .json,
                                   headers: ["Accept":"application/json"])
        
        networkManager.request(target: target, parameters: authRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let authResponse = self?.objectConverter.convertJsonToObject(from: data, to: AuthResponse.self)
                self?.setGithubAccessToken(token: authResponse?.accessToken)
            case .failure(let error):
                Log.error("\(error.localizedDescription)")
            }
        }
    }
    
    private func setGithubAccessToken(token: String?) {
        guard let token = token else {
            Log.error("access token value nil")
            return
        }
        
        Log.debug("token: \(token)")
        authToken.value = token
    }
}
