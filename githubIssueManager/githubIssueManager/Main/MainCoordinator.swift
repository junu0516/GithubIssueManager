import UIKit

final class MainCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    
    required init() {
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = .systemBackground
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
