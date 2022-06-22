import UIKit
import SnapKit

final class IssueListTableViewCell: TableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .gray
        return label
    }()

    private let milestoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .gray
        return label
    }()
    
    func bind(to viewModel: IssueListTableViewCellModel) {
        
        viewModel.output.title.bind { [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.output.issueDescription.bind { [weak self] in
            self?.descriptionLabel.text = $0
        }
        
        viewModel.output.milestone.bind { [weak self] in
            self?.milestoneLabel.text = $0
        }
        
    }
    
    override func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(milestoneLabel)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
