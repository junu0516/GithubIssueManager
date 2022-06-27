import XCTest
@testable import githubIssueManager

class LabelInsertViewModelTest: XCTestCase {
    
    private var networkManager: MockNetworkManager!
    private var viewModel: LabelInsertViewModel!

    override func setUpWithError() throws {
        
        self.networkManager = MockNetworkManager()
        
        let repository = LabelInsertRepository(networkManager: networkManager)
        self.viewModel = LabelInsertViewModel(repository: repository)
    }
    
    func test_inserting_label_success() throws {
        networkManager.shouldFail = false
        
        XCTAssertNil(viewModel.output.labelInsertResult.value)
        
        viewModel.input.titleUpdated.value = "label title"
        viewModel.input.descriptionUpdated.value = "label description"
        viewModel.input.colorChangeButtonTapped.value = true
        viewModel.input.saveButtonTapped.value = true
        
        let result = try XCTUnwrap(viewModel.output.labelInsertResult.value)
        XCTAssertEqual(result, true)
    }
    
    func test_inserting_label_failure() throws {
        networkManager.shouldFail = true
        
        XCTAssertNil(viewModel.output.labelInsertResult.value)
        
        viewModel.input.titleUpdated.value = "label title"
        viewModel.input.descriptionUpdated.value = "label description"
        viewModel.input.colorChangeButtonTapped.value = true
        viewModel.input.saveButtonTapped.value = true
        
        XCTAssertNil(viewModel.output.labelInsertResult.value)
    }
}
