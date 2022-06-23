import XCTest
@testable import githubIssueManager

class LoginViewModelTest: XCTestCase {

    private var networkManager: MockNetworkManager!
    private var viewModel: LoginViewModel!

    override func setUpWithError() throws {
        self.networkManager = MockNetworkManager()
        
        let repository = LoginRepository(networkManager: networkManager)
        self.viewModel = LoginViewModel(repository: repository)
    }

    func test_getting_authentication_url() {
        
        XCTAssertNil(viewModel.output.loginUrl.value)
        
        viewModel.input.loginButtonTapped.value = true
        XCTAssertNotNil(viewModel.output.loginUrl.value)
    }

}
