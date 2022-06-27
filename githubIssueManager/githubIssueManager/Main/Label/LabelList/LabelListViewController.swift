import UIKit
import SnapKit

final class LabelListViewController: UIViewController {
    
    private var viewModel: LabelListViewModel?
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    private let labelDataSource = TableViewDataSource<LabelListTableViewCell, LabelListTableViewCellModel>.create()
    private lazy var labelTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = .lightGray
        tableView.register(LabelListTableViewCell.self,
                           forCellReuseIdentifier: LabelListTableViewCell.identifier)
        tableView.dataSource = labelDataSource
        return tableView
    }()
    
    convenience init(viewModel: LabelListViewModel) {
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
        
        viewModel?.input.labelListRequested.value = true
    }
    
    private func addViews() {
        
        view.addSubview(labelTableView)
        labelTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        viewModel?.output.labelCellModels.bind { [weak self] in
            self?.labelDataSource.items = $0
            self?.labelTableView.reloadData()
        }
        
        addButton.tapped { [weak self] in
            self?.viewModel?.input.insertButtonTapped.value = true
        }
    }
    
    private func setAttributes() {
        title = "레이블"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
    }
}

extension TableViewDataSource where Model == LabelListTableViewCellModel,
                                    Cell == LabelListTableViewCell{
    
    static func create(models: [LabelListTableViewCellModel] = []) -> TableViewDataSource {
        return TableViewDataSource(models: models) { cell, model in
            cell.bind(to: model)
        }
    }
}
