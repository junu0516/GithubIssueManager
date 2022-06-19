import UIKit

final class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?

    required init() {}
    
    func start() {
        moveToFirstView(type: LoginCoordinator.self)
    }
    
    private func moveToFirstView<T: Coordinator>(type: T.Type) {
        guard let coordinator = CoordinatorFactory.createCoordinator(type: type) else { return }
        coordinator.start()
        addCoordinator(coordinator)
        self.navigationController = coordinator.navigationController
        Log.debug("set \(type) as initial view controller")
    }
    
    func setGithubAccessToken(token: String?) {
        guard let token = token else {
            Log.error("access token value nil")
            return
        }
        Log.debug("token: \(token)")
    }
}

