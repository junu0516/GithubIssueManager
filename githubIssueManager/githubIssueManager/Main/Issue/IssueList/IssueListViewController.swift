import UIKit
import SnapKit

final class IssueListViewController: UIViewController {
    
    private var viewModel: IssueListViewModel?
    
    private lazy var issueTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .lightGray
        tableView.register(IssueListTableViewCell.self, forCellReuseIdentifier: IssueListTableViewCell.identifier)
        tableView.dataSource = issueDataSource
        return tableView
    }()
    private let issueDataSource = TableViewDataSource.create()
    
    private let filterButton: UIButton = {
        let button = UIButton()
        button.setTitle("필터", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    convenience init(viewModel: IssueListViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setAttributes()
        addViews()
        bind()
    }
    
    private func bind() {
        viewModel?.input.issueListRequested.value = true
        
        viewModel?.output.issueViewModels.bind { [weak self]  in
            self?.issueDataSource.items = $0
            self?.issueTableView.reloadData()
        }
    }
    
    private func setAttributes() {
        title = "이슈"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: filterButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: selectButton)
        navigationItem.searchController = UISearchController()
    }
    
    private func addViews() {

        view.addSubview(issueTableView)
        issueTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
     
    }
}

extension TableViewDataSource where Model == IssueListTableViewCellModel,
                                    Cell == IssueListTableViewCell{
    
    static func create(models: [IssueListTableViewCellModel] = []) -> TableViewDataSource {
        return TableViewDataSource(models: models) { cell, model in
            cell.bind(to: model)
        }
    }
}
