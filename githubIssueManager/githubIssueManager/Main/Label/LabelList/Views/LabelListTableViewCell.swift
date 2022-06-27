import UIKit
import SnapKit

final class LabelListTableViewCell: TableViewCell {
    
    private lazy var paddinglabel: PaddingLabel = {
       let label = PaddingLabel()
        label.padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
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
            self?.paddinglabel.text = $0
        }
        
        viewModel.output.description.bind { [weak self] in
            self?.descriptoinLabel.text = $0
        }
        
        viewModel.output.color.bind { [weak self] in
            self?.paddinglabel.backgroundColor = $0.hexToColor()
            self?.paddinglabel.textColor = $0.hexToColor().contrast
        }
    }
    
    override final func addViews() {
        
        contentView.addSubview(paddinglabel)
        paddinglabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().inset(15)
        }
        
        contentView.addSubview(descriptoinLabel)
        descriptoinLabel.snp.makeConstraints {
            $0.top.equalTo(paddinglabel.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
