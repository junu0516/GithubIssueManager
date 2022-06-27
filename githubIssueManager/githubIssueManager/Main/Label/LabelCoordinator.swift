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
        let viewModel = LabelListViewModel(navigation: self)
        let viewController = LabelListViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension LabelCoordinator: LabelNavigation {
    
}
