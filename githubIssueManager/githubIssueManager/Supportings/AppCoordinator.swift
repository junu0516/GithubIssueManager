import UIKit

protocol AppCoordinatorDelegate: AnyObject {
    func switchRootView(navigationController: UINavigationController?)
}

final class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    private (set)var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    weak var delegate: AppCoordinatorDelegate?

    @UserDefault(key: .authToken)
    private var storedAccessToken: String
    
    var accessToken: String? {
        didSet {
            storedAccessToken = accessToken ?? ""
        }
    }
    
    required init() {}
    
    func start() {
        if isTokenAvailable() {
            moveToViewController(type: MainCoordinator.self)
        } else {
            moveToViewController(type: LoginCoordinator.self)
        }
    }
    
    private func isTokenAvailable() -> Bool {
        return !storedAccessToken.isEmpty
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
    
    func moveToMainViewController() {
        moveToViewController(type: MainCoordinator.self)
        delegate?.switchRootView(navigationController: navigationController)
    }
}

