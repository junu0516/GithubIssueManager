import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func switchRootView(navigationController: UINavigationController?)
}

final class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    private (set)var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    weak var delegate: AppCoordinatorDelegate?

    required init() {}
    
    func start() {
        if isTokenAvailable() {
            moveToViewController(type: MainCoordinator.self)
        } else {
            moveToViewController(type: LoginCoordinator.self)
        }
    }
    
    private func isTokenAvailable() -> Bool {
        return UserDefaults.standard.object(forKey: "Github_Access_Token") != nil
    }
    
    private func moveToViewController<T: Coordinator>(type: T.Type) {
        guard let coordinator = CoordinatorFactory.create(type: type) else { return }
        childCoordinators.removeAll()
        coordinator.parentCoordinator = self
        self.navigationController = coordinator.navigationController
        childCoordinators.append(coordinator)
        coordinator.start()
        Log.debug("move to \(type)")
    }
    
    func setGithubAccessToken(token: String?) {
        guard let token = token else {
            Log.error("access token value nil")
            return
        }
        
        Log.debug("token: \(token)")
        UserDefaults.standard.set(token, forKey: "Github_Access_Token")

        moveToViewController(type: MainCoordinator.self)
        delegate?.switchRootView(navigationController: navigationController)
    }
}

