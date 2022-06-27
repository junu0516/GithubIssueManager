import Foundation

struct LabelListRepository {
    
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible
    
    @UserDefault(key: .authToken)
    private var accessToken: String
    
    init(networkManager: NetworkManagable = NetworkManager(),
         objectConverter: ObjectConvertible = ObjectConverter()) {
        self.networkManager = networkManager
        self.objectConverter = objectConverter
    }
    
    func requestLabels(completion: @escaping ([Label]) -> Void) {
        guard let target = NetworkTarget(path: .labels(owner: "junu0516", repo: "GithubIssueManager"),
                                         method: .get,
                                         paramteterType: .json,
                                         headers: ["Accept":"application/vnd.github.v3+json",
                                                   "Authorization":"token \(accessToken)"]) else { return }
        
        networkManager.request(target: target,
                               parameters: Optional<String>.none) { result in
            switch result {
            case .success(let data):
                let labels = objectConverter.convertJsonToObject(from: data, to: [Label].self)
                Log.debug("\(labels)")
                completion(labels ?? [])
            case .failure(let error):
                Log.error("\(error)")
            }
        }
    }
}
