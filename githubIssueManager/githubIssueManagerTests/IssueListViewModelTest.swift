import XCTest
@testable import githubIssueManager

class IssueListViewModelTest: XCTestCase {
    
    private var networkManager: MockNetworkManager!
    private var viewModel: IssueListViewModel!
    
    override func setUpWithError() throws {
        self.networkManager = MockNetworkManager()
        
        let repository = IssueListRepository(networkManager: networkManager)
        self.viewModel = IssueListViewModel(repository: repository)
    }
    
    // 목데이터 불러오기 테스트
    func test_loading_mock_data() {
        networkManager.loadMockData(mockData: .issues)
        XCTAssertNotNil(networkManager.mockResponseData)
    }

    // 이슈 리스트 불러오기 테스트
    func test_fetching_issues_success() throws {
        networkManager.shouldFail = false

        XCTAssertNil(viewModel.output.issueViewModels.value)
        
        viewModel.input.issueListRequested.value = true
        XCTAssertNotNil(viewModel.output.issueViewModels.value)
        
        let issues = try XCTUnwrap(viewModel.output.issueViewModels.value)
        XCTAssertGreaterThan(issues.count, 0)
    }
    
    func test_fetching_issues_failure() throws {
        networkManager.shouldFail = true

        XCTAssertNil(viewModel.output.issueViewModels.value)
        
        viewModel.input.issueListRequested.value = true
        XCTAssertNil(viewModel.output.issueViewModels.value)        
    }
}
