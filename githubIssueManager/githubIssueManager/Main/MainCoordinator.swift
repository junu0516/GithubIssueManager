import UIKit

final class MainCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    private (set)var childCoordinators: [Coordinator] = []
    private (set)var navigationController: UINavigationController?
    
    required init() {
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = .systemBackground
    }
    
    func start() {
        for childView in ChildView.allCases {
            guard let coordinator = childView.coordinator else { continue }
            coordinator.parentCoordinator = self
            coordinator.navigationController?.tabBarItem = childView.tabbarItem
            childCoordinators.append(coordinator)
            coordinator.start()
        }
        
        applyTabBarController()
    }
    
    private func applyTabBarController() {
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = childCoordinators.compactMap { $0.navigationController }
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.pushViewController(tabbarController, animated: true)
    }
}

extension MainCoordinator {
    
    enum ChildView: CaseIterable {
        case issue
        case label
        case milestone
        
        var coordinator: Coordinator? {
            switch self {
            case .issue:
                return CoordinatorFactory.create(type: IssueListCoordinator.self)
            case .label:
                return CoordinatorFactory.create(type: IssueListCoordinator.self)
            case .milestone:
                return CoordinatorFactory.create(type: IssueListCoordinator.self)
            }
        }
        
        var tabbarItem: UITabBarItem {
            switch self {
            case .issue:
                return UITabBarItem(title: "이슈", image: UIImage(named: "icon_issues"), tag: 0)
            case .label:
                return UITabBarItem(title: "라벨", image: UIImage(named: "icon_labels"), tag: 1)
            case .milestone:
                return UITabBarItem(title: "마일스톤", image: UIImage(named: "icon_milestones"), tag: 2)
            }
        }
    }
}
