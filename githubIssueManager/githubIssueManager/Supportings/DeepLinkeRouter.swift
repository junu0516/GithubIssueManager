import Foundation

final class DeepLinkRouter {
    
    private weak var appCoordinator: AppCoordinator?
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible

    var authCode = Observable<String>()
    
    init?(appCoordinator: Coordinator?,
          networkManager: NetworkManagable = NetworkManager(),
          objectConverter: ObjectConvertible = ObjectConverter()) {
        guard let appCoordinator = appCoordinator as? AppCoordinator else { return nil }

        self.appCoordinator = appCoordinator
        self.networkManager = networkManager
        self.objectConverter = objectConverter
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
        
        guard let target = NetworkTarget(path: .githubAccessToken,
                                         method: .post,
                                         paramteterType: .json,
                                         headers: ["Accept":"application/json"]) else { return }
        networkManager.request(target: target, parameters: authRequest) { [weak self] result in
            switch result {
            case .success(let data):
                let authResponse = self?.objectConverter.convertJsonToObject(from: data, to: AuthResponse.self)
                self?.appCoordinator?.setGithubAccessToken(token: authResponse?.accessToken)
            case .failure(let error):
                Log.error("\(error.localizedDescription)")
            }
        }
    }
}
