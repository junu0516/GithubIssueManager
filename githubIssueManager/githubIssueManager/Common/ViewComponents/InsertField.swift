import UIKit
import SnapKit

final class InsertField: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var placeHolder: String? {
        didSet {
            textField.placeholder = placeHolder
        }
    }
    
    var rightButton: UIButton? {
        didSet {
            textField.rightViewMode = .always
            textField.rightView = rightButton
        }
    }
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        self.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

extension InsertField {
    
    func editted(action: @escaping (String?) -> Void ) {
        textField.addAction(UIAction(handler: { [weak self] _ in
            action(self?.textField.text)
        }), for: .editingChanged)
    }
}
