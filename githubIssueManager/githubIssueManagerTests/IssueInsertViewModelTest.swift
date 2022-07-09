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
    
    func test_inserting_issue_success() throws {
        networkManager.shouldFail = false
        
        XCTAssertNil(viewModel.output.issueInsertResult.value)
        
        viewModel.output.selectedLabels.value = [Label(title: "label", description: "description", color: "FFFFFF")]
        viewModel.output.selectedAssignees.value = [Assignee(title: "assignee")]
        viewModel.output.selectedMilestones.value = [Milestone(title: "milestone", number: 0)]
        viewModel.output.updatedTitle.value = "title"
        viewModel.output.updatedBody.value = "body"
        
        viewModel.input.saveButtonTapped.value = true
        
        XCTAssertNotNil(viewModel.output.issueInsertResult.value)
    }
    
    func test_inserting_issue_failure() throws {
        networkManager.shouldFail = true
        
        XCTAssertNil(viewModel.output.issueInsertResult.value)
        
        viewModel.output.selectedLabels.value = [Label(title: "label", description: "description", color: "FFFFFF")]
        viewModel.output.selectedAssignees.value = [Assignee(title: "assignee")]
        viewModel.output.selectedMilestones.value = [Milestone(title: "milestone", number: 0)]
        viewModel.output.updatedTitle.value = "title"
        viewModel.output.updatedBody.value = "body"
        
        viewModel.input.saveButtonTapped.value = true
        
        XCTAssertNil(viewModel.output.issueInsertResult.value)
    }
    
    func test_inserting_issue_missing_request_parameter() throws {
        networkManager.shouldFail = false
        
        XCTAssertNil(viewModel.output.issueInsertResult.value)
        viewModel.input.saveButtonTapped.value = true
        
        XCTAssertNil(viewModel.output.issueInsertResult.value)
    }
}
