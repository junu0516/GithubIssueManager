import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?

    required init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        Log.debug("started LoginCoordinator")
        let viewController = LoginViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
