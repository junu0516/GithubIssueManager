import UIKit

protocol LabelNavigation: AnyObject {}

final class LabelCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    private (set)var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?

    required init() {
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = .white
    }
    
    func start() {
        let viewController = LabelListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
