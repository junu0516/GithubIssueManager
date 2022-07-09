import Foundation
import Alamofire

struct NetworkManager: NetworkManagable {
    
    private let objectConverter: ObjectConvertible
    
    init(objectConverter: ObjectConvertible = ObjectConverter()) {
        self.objectConverter = objectConverter
    }
    
    private func parameters<T:Encodable>(_ parameters: T?) -> [String:Any]? {
        guard let parameters = parameters else { return nil}
        return objectConverter.convertObjectToDictionary(from: parameters)
    }
    
    private func encoder(parameterType: ParameterType) -> ParameterEncoding {
        switch parameterType {
        case .json:
            return JSONEncoding.prettyPrinted
        case .form:
            return URLEncoding.default
        case .query:
            return URLEncoding.queryString
        }
    }
    
    func request<T:Encodable>(target: NetworkTarget,
                              parameters: T?,
                              completion: @escaping (Result<Data, Error>) -> Void) {

        guard let url = URLComponents(string: "\(target.path)") else {
            completion(.failure(URLError.error))
            return
        }
        
        AF.request(url,
                   method: HTTPMethod(rawValue: "\(target.method)"),
                   parameters: self.parameters(parameters),
                   encoding: encoder(parameterType: target.paramterType),
                   headers: HTTPHeaders(target.headers))
        .validate(statusCode: 200..<300)
        .responseData { response in
            trackRequest(request: response.request)
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func trackRequest(request: URLRequest?) {
        guard let request = request else {
            Log.error("request nil")
            return
        }
        
        let data = request.httpBody ?? Data()
        Log.debug("\(request)\t\(request.httpMethod ?? "")\n\(String(data: data, encoding: .utf8) ?? "")")
    }
}

extension NetworkManager {
    
    enum URLError: Error, LocalizedError {
        
        case error
        
        var errorDescription: String? {
            return "Failed generating URLComponents from NetworkTarget Object"
        }
    }
}
