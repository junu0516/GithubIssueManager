import Foundation

enum ParameterType {
    case json
    case form
    case query
}

struct NetworkTarget {
    
    let path: Path
    let method: HttpMethod
    let headers: [String:String]
    let paramterType: ParameterType
    
    init(path: Path,
          method: HttpMethod = HttpMethod.get,
          paramteterType: ParameterType,
          headers: [String:String] = ["content-type":"applicatin/json"]) {
        
        self.path = path
        self.method = method
        self.headers = headers
        self.paramterType = paramteterType
    }
}
