import Foundation

final class MockNetworkManager: NetworkManagable {
    
    //Mock 객체 내부에서 사용할 사용자 정의 에러 열거형
    enum TestError: Error, LocalizedError {
        case mockDataNotLoaded
        case responseError
        
        var errorDescription: String? {
            switch self {
            case .mockDataNotLoaded:
                return "TestError.\(self) : Mock Data Not Loaded"
            case .responseError:
                return "TestError.\(self) : Response Error"
            }
        }
    }
    
    //미리 성공, 실패 여부를 결정
    var shouldFail: Bool = true
    
    func request<T: Encodable>(target: NetworkTarget, parameters: T?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        switch shouldFail {
        case false:
            //성공한 응답가지고 클로저 호출
            do {
                let mockResponseData = try getMockDatWithPath(path: target.path)
                completion(.success(mockResponseData))
            } catch {
                Log.error(error.localizedDescription)
            }
        case true:
            //실패한 응답 가지고 클로저 호출
            completion(.failure(TestError.responseError))
        }
    }
    
    private func getMockDatWithPath(path: Path) throws -> Data {
        switch path {
        case .githubLogin(_):
            return Data()
        case .githubAccessToken:
            return try loadMockData(mockData: .authentication)
        case .issues(_,_):
            return try loadMockData(mockData: .issues)
        case .milestones(_,_):
            return try loadMockData(mockData: .milestones)
        case .labels(_,_):
            return try loadMockData(mockData: .labels)
        case .assignees(_,_):
            return try loadMockData(mockData: .assignees)
        }
    }
    
    //필요 시 로컬에 미리 저장된 json 데이터를 가지고옴
    private func loadMockData(mockData: MockData) throws -> Data {
        guard let path = Bundle.main.url(forResource: mockData.fileName, withExtension: "json") else {
            throw TestError.mockDataNotLoaded
        }
        guard let data: Data = try? Data(contentsOf: path) else {
            throw TestError.mockDataNotLoaded
        }

        return data
    }
}

extension MockNetworkManager {
    
    enum MockData {
        case issues
        case authentication
        case labels
        case milestones
        case assignees
        
        var fileName: String {
            switch self {
            case .issues:
                return "issues"
            case .authentication:
                return "authentication"
            case .labels:
                return "labels"
            case .milestones:
                return "milestones"
            case .assignees:
                return "assignees"
            }
        }
    }
}
