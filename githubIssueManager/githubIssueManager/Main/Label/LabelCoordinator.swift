import UIKit

protocol LabelNavigation: AnyObject {
    
    func moveToLabelInsert()
    func goBackToLabelList()
}

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
    
    func moveToLabelInsert() {
        let viewModel = LabelInsertViewModel(navigation: self)
        let viewController = LabelInsertViewController(viewModel: viewModel)
        let childNavigation = UINavigationController(rootViewController: viewController)
        navigationController?.present(childNavigation, animated: true)
    }
    
    func goBackToLabelList() {
        navigationController?.presentedViewController?.dismiss(animated: true)
    }
}
