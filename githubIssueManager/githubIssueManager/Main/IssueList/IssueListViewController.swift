import UIKit
import SnapKit

final class IssueListViewController: UIViewController {
    
    private var viewModel: IssueListViewModel?
    
    private let issueTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .lightGray
        return tableView
    }()
    
    convenience init(viewModel: IssueListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "이슈"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
