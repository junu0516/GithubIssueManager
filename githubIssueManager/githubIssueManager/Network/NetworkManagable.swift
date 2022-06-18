import Foundation

protocol NetworkManagable {
    
    func request<T:Encodable>(target: NetworkTarget, parameters: T?, completion: @escaping (Result<Data, Error>) -> Void)
}
