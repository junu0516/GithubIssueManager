import Foundation

struct NetworkTarget {
    
    let url: URLComponents
    let method: HttpMethod
    let headers: [String:String]
    
    init?(path: Path,
          method: HttpMethod = HttpMethod.get,
          headers: [String:String] = ["content-type":"applicatin/json"]) {
        guard let url = URLComponents(string: "\(path)") else { return nil }
        
        self.url = url
        self.method = method
        self.headers = headers
    }
}
