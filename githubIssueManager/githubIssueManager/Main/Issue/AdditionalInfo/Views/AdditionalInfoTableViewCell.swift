import UIKit
import SnapKit

final class AdditionalInfoTableViewCell: TableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    
    func bind(to viewModel: AdditionalInfoTableViewCellModel) {
                
        viewModel.output.title.bind { [weak self] in
            self?.titleLabel.text = $0
        }
        
        viewModel.output.isSelected.bind { [weak self] isSelected in
            let tintColor: UIColor = isSelected ? .systemBlue : .lightGray
            self?.checkButton.imageView?.tintColor = tintColor
        }
        
        checkButton.tapped {
            viewModel.input.isTouched.value?.toggle()
        }
    }
    
    override func addViews() {
        
        contentView.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.width.equalTo(checkButton.snp.height)
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(25)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalTo(checkButton.snp.trailing).offset(15)
        }
    }
}
