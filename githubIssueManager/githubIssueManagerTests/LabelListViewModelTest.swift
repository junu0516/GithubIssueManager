import XCTest
@testable import githubIssueManager

class LabelListViewModelTest: XCTestCase {

    private var networkManager: MockNetworkManager!
    private var viewModel: LabelListViewModel!

    
    override func setUpWithError() throws {
        self.networkManager = MockNetworkManager()
        
        let repository = LabelListRepository(networkManager: networkManager)
        self.viewModel = LabelListViewModel(repository: repository)
    }
    
    func test_fetching_labels_success() throws {
        networkManager.shouldFail = false
        
        XCTAssertNil(viewModel.output.labelCellModels.value)
        
        viewModel.input.labelListRequested.value = true
        let labels = try XCTUnwrap(viewModel.output.labelCellModels.value)
        XCTAssertGreaterThan(labels.count, 0)
    }
    
    func test_fetching_labels_failure() throws {
        networkManager.shouldFail = true
        
        XCTAssertNil(viewModel.output.labelCellModels.value)
        
        viewModel.input.labelListRequested.value = true
        XCTAssertNil(viewModel.output.labelCellModels.value)
    }

}
