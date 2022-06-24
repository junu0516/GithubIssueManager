import UIKit

protocol IssueNavigation: AnyObject {
    
    func moveToIssueInsert()
}

final class IssueCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    private (set)var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    
    required init() {
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = .systemBackground
    }
    
    func start() {
        let viewModel = IssueListViewModel(navigation: self)
        let viewController = IssueListViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
    }
}
