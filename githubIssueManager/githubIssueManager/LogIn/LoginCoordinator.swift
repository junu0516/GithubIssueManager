import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?

    required init() {
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = .systemBackground
    }

    func start() {
        Log.debug("started LoginCoordinator")
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
