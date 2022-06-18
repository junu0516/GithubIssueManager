import Foundation
import Alamofire

struct NetworkManager: NetworkManagable {
    
    private let encoder = JSONEncoder()
    
    func request<T:Encodable>(target: NetworkTarget, body: T?, completion: @escaping (Result<Data, Error>) -> Void) {

        AF.request(target.url,
                   method: HTTPMethod(rawValue: "\(target.method)"),
                   parameters: body,
                   headers: HTTPHeaders(target.headers))
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
