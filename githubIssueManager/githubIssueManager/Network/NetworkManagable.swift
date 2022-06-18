import Foundation

protocol NetworkManagable {
    func request(target: NetworkTarget, body: Data?, completion: @escaping (Result<Data, Error>) -> Void)
}
