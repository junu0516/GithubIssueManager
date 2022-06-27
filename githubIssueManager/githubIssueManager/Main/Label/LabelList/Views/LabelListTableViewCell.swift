import UIKit
import SnapKit

final class LabelListTableViewCell: TableViewCell {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        return label
    }()
    
    private let descriptoinLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .gray
        return label
    }()
    
    func bind(to viewModel: LabelListTableViewCellModel) {
        
        viewModel.output.title.bind { [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.output.description.bind { [weak self] in
            self?.descriptoinLabel.text = $0
        }
    }
    
    override final func addViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptoinLabel)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
}
