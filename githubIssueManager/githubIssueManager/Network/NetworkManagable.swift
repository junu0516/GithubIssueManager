import Foundation

protocol NetworkManagable {
    
    func request<T:Encodable>(target: NetworkTarget, body: T?, completion: @escaping (Result<Data, Error>) -> Void)
}
