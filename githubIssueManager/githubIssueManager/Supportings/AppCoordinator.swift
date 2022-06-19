import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func switchRootView(navigationController: UINavigationController?)
}

final class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    weak var delegate: AppCoordinatorDelegate?

    required init() {}
    
    func start() {
        moveToViewController(type: LoginCoordinator.self)
    }
    
    private func moveToViewController<T: Coordinator>(type: T.Type) {
        guard let coordinator = CoordinatorFactory.create(type: type) else { return }
        childCoordinators.removeAll()
        coordinator.parentCoordinator = self
        self.navigationController = coordinator.navigationController
        addCoordinator(coordinator)
        coordinator.start()
        Log.debug("move to \(type)")
    }
    
    func setGithubAccessToken(token: String?) {
        guard let token = token else {
            Log.error("access token value nil")
            return
        }
        Log.debug("token: \(token)")
        
        moveToViewController(type: MainCoordinator.self)
        delegate?.switchRootView(navigationController: navigationController)
    }
}

