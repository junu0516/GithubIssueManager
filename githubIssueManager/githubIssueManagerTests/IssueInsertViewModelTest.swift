import XCTest
@testable import githubIssueManager

class IssueInsertViewModelTest: XCTestCase {

    private var networkManager: MockNetworkManager!
    private var viewModel: IssueInsertViewModel!

    
    override func setUpWithError() throws {
        self.networkManager = MockNetworkManager()
        
        let repository = IssueInsertRepository(networkManager: networkManager)
        self.viewModel = IssueInsertViewModel(repository: repository)
    }
    
    func test_loading_mock_data() {
        XCTAssertNil(networkManager.mockResponseData)

        networkManager.loadMockData(mockData: .assignees)
        XCTAssertNotNil(networkManager.mockResponseData)
        
        networkManager.mockResponseData = nil
        networkManager.loadMockData(mockData: .labels)
        XCTAssertNotNil(networkManager.mockResponseData)

        networkManager.mockResponseData = nil
        networkManager.loadMockData(mockData: .milestones)
        XCTAssertNotNil(networkManager.mockResponseData)
    }

    func test_fetching_repo_info_success() throws {
        networkManager.shouldFail = false
        
        XCTAssertNil(viewModel.input.assignees.value)
        XCTAssertNil(viewModel.input.labels.value)
        XCTAssertNil(viewModel.input.milestones.value)
        
        viewModel.input.repoInfoRequested.value = true

        let assignees = try XCTUnwrap(viewModel.input.assignees.value)
        let labels = try XCTUnwrap(viewModel.input.labels.value)
        let milestones = try XCTUnwrap(viewModel.input.milestones.value)
        
        DispatchQueue.global(qos: .background).sync {
            XCTAssertGreaterThan(assignees.count, 0)
            XCTAssertGreaterThan(labels.count, 0)
            XCTAssertGreaterThan(milestones.count, 0)
        }
    }

    func test_fetching_repo_info_failure() throws {
        networkManager.shouldFail = true
        
        XCTAssertNil(viewModel.input.assignees.value)
        XCTAssertNil(viewModel.input.labels.value)
        XCTAssertNil(viewModel.input.milestones.value)
        
        viewModel.input.repoInfoRequested.value = true

        DispatchQueue.global(qos: .background).sync {
            XCTAssertNil(viewModel.input.assignees.value)
            XCTAssertNil(viewModel.input.labels.value)
            XCTAssertNil(viewModel.input.milestones.value)
        }
    }
}
