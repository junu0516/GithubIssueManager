import Foundation

enum ParameterType {
    case json
    case form
    case query
}

struct NetworkTarget {
    
    let path: Path
    let url: URLComponents
    let method: HttpMethod
    let headers: [String:String]
    let paramterType: ParameterType
    
    init?(path: Path,
          method: HttpMethod = HttpMethod.get,
          paramteterType: ParameterType,
          headers: [String:String] = ["content-type":"applicatin/json"]) {
        guard let url = URLComponents(string: "\(path)") else {
            return nil
        }
        
        self.path = path
        self.url = url
        self.method = method
        self.headers = headers
        self.paramterType = paramteterType
    }
}
