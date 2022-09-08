import UIKit

protocol IssueNavigation: AnyObject {
    
    func moveToIssueInsert()
    func showInfoSelectView(models: [TitleValuePossessible], allowsMultipleSelection: Bool, saveOperation: @escaping ([Int]) -> Void)
    func closeSelectView()
    func goBackToIssueList()
    func moveToIssueDetail(issueIndex: Int)
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

extension IssueCoordinator: IssueNavigation {
    
    func moveToIssueInsert() {
        let viewModel = IssueInsertViewModel(navigation: self)
        let viewController = IssueInsertViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showInfoSelectView(
        models: [TitleValuePossessible],
        allowsMultipleSelection: Bool,
        saveOperation: @escaping ([Int]) -> Void) {
            
        let viewModel = AdditionalInfoViewModel(
            titles: models,
            navigation: self,
            allowsMultipleSelection: allowsMultipleSelection,
            saveOperation: saveOperation
        )
        let viewController = AdditionalInfoViewController(viewModel: viewModel)
        let childNavigation = UINavigationController(rootViewController: viewController)
        navigationController?.present(childNavigation, animated: true)
    }
    
    func closeSelectView() {
        navigationController?.presentedViewController?.dismiss(animated: true)
    }
    
    func goBackToIssueList() {
        navigationController?.popViewController(animated: true)
    }
    
    func moveToIssueDetail(issueIndex: Int) {
        Log.debug("index number: \(issueIndex)")
    }
}
