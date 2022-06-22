import Foundation

struct IssueListRepository {
    
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible
    
    init(networkManager: NetworkManagable = NetworkManager(),
         objectConverter: ObjectConvertible = ObjectConverter()) {
        self.networkManager = networkManager
        self.objectConverter = objectConverter
    }
    
    func requestIssues(completion: @escaping ([Issue]) -> Void) {
        guard let token = UserDefaults.standard.object(forKey: "Github_Access_Token") as? String else { return }
        guard let target = NetworkTarget(path: .githubIssues(owner: "junu0516", repo: "GithubIssueManager"),
                                         method: .get,
                                         paramteterType: .json,
                                         headers: ["Accept":"application/vnd.github.v3+json",
                                                   "Authorization":"toekn \(token)"]) else { return }
        
        networkManager.request(target: target,
                               parameters: Optional<String>.none) { result in
            switch result {
            case .success(let data):
                if let issues = objectConverter.convertJsonToObject(from: data, to: [Issue].self) {
                    completion(issues)
                } else {
                    Log.error("Parsing error")
                }
            case .failure(let error):
                Log.error("\(error)")
            }
        }
    }
}
