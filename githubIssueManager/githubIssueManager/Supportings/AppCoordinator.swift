import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?

    required init() {}
    
    func start() {
    }
    
    private func moveToFirstView<T: Coordinator>(type: T.Type) {
        guard let coordinator = CoordinatorFactory.createCoordinator(type: type) else { return }
        coordinator.start()
        addCoordinator(coordinator)
        self.navigationController = coordinator.navigationController
        Log.debug("set UIViewController in \(type) as first view")
    }
}
