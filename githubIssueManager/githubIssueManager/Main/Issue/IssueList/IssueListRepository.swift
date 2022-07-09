import Foundation

struct IssueListRepository {
    
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible
    
    @UserDefault(key: .authToken)
    private var accessToken: String
    
    init(networkManager: NetworkManagable = NetworkManager(),
         objectConverter: ObjectConvertible = ObjectConverter()) {
        self.networkManager = networkManager
        self.objectConverter = objectConverter
    }
    
    func requestIssues(completion: @escaping ([Issue]) -> Void) {
        let target = NetworkTarget(path: .issues(owner: "junu0516", repo: "GithubIssueManager"),
                                   method: .get,
                                   paramteterType: .json,
                                   headers: ["Accept":"application/vnd.github.v3+json",
                                             "Authorization":"token \(accessToken)"])
        
        networkManager.request(target: target,
                               parameters: Optional<String>.none) { result in
            switch result {
            case .success(let data):
                let issues = objectConverter.convertJsonToObject(from: data, to: [Issue].self)
                completion(issues ?? [])
            case .failure(let error):
                Log.error("\(error)")
            }
        }
    }
}
