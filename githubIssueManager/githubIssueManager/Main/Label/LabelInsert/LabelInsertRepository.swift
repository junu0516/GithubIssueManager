import Foundation

struct LabelInsertRepository {
    
    private let networkManager: NetworkManagable
    private let objectConverter: ObjectConvertible
    
    @UserDefault(key: .authToken)
    private var accessToken: String
    
    init(networkManager: NetworkManagable = NetworkManager(),
         objectConverter: ObjectConvertible = ObjectConverter()) {
        self.networkManager = networkManager
        self.objectConverter = objectConverter
    }
    
    func requestAddingLabel(label: Label, completion: @escaping () -> Void) {
        
        let target = NetworkTarget(path: .labels(owner: "junu0516", repo: "GithubIssueManager"),
                                   method: .post,
                                   paramteterType: .json,
                                   headers: ["Accept":"application/vnd.github.v3+json",
                                             "Authorization":"token \(accessToken)"])
        
        networkManager.request(target: target, parameters: label) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                Log.error("\(error.localizedDescription)")
            }
            
        }
    }
}
