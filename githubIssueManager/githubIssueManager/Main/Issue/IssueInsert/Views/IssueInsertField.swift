import SnapKit
import UIKit

final class IssueInsertField: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
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
    
    var text: String? {
        didSet {
            textField.text = text
        }
    }
    
    var isTextingEnabled: Bool = true {
        didSet {
            textField.isUserInteractionEnabled = isTextingEnabled
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.22)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        self.addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
