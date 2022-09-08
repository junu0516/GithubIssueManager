import UIKit
import SnapKit

final class AdditionalInfoTableViewCell: TableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let checkImage = UIImageView(image: .init(systemName: "checkmark.circle"))
    
    func bind(to viewModel: AdditionalInfoTableViewCellModel) {
        
        selectionHandler = { [weak self] in
            viewModel.input.isTouched.value = self?.isSelected
        }
        
        viewModel.output.title.bind { [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.output.isSelected.bind { [weak self] isSelected in
            let tintColor: UIColor = isSelected ? .systemBlue : .lightGray
            self?.checkImage.tintColor = tintColor
        }
    }
    
    override func addViews() {
        
        contentView.addSubview(checkImage)
        checkImage.snp.makeConstraints {
            $0.width.equalTo(checkImage.snp.height)
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalTo(checkImage.snp.trailing).offset(15)
        }
    }
}
