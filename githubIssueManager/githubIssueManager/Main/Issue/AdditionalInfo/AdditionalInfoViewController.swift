import UIKit
import SnapKit

final class AdditionalInfoViewController: UIViewController {
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdditionalInfoTableViewCell.self,
                           forCellReuseIdentifier: AdditionalInfoTableViewCell.identifier)
        tableView.dataSource = additionalInfoDataSource
        return tableView
    }()
    private let additionalInfoDataSource = TableViewDataSource<AdditionalInfoTableViewCell, AdditionalInfoTableViewCellModel>.create()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private var viewModel: AdditionalInfoViewModel?
    
    convenience init(viewModel: AdditionalInfoViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViews()
        setAttributes()
        bind()
    }
    
    private func bind() {
        
        viewModel?.output.infoViewModels.bind { [weak self] models in
            self?.additionalInfoDataSource.items = models
            self?.infoTableView.reloadData()
        }
        
        saveButton.tapped { [weak self] in
            self?.viewModel?.input.saveButtonTapped.value = true
        }
        
        cancelButton.tapped { [weak self] in
            self?.viewModel?.input.cancelButtonTapped.value = true
        }
    }
    
    private func addViews() {
                
        view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setAttributes() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "선택"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
}

extension TableViewDataSource where Model == AdditionalInfoTableViewCellModel,
                                    Cell == AdditionalInfoTableViewCell{
    
    static func create(models: [AdditionalInfoTableViewCellModel] = []) -> TableViewDataSource {
        return TableViewDataSource(models: models) { cell, model in
            cell.bind(to: model)
        }
    }
}


