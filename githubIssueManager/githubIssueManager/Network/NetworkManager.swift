import Foundation
import Alamofire

struct NetworkManager: NetworkManagable {
    
    func request(target: NetworkTarget, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard var request = try? URLRequest(url: target.url,
                                            method: HTTPMethod(rawValue: "\(target.method)"),
                                            headers: HTTPHeaders(target.headers)) else { return }
        request.httpBody = body
        
        AF.request(request)
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
