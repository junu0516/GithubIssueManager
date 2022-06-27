import SnapKit
import UIKit

final class IssueInsertForm: UIView {
    
    let labelField: IssueInsertField = {
        let insertField = IssueInsertField()
        insertField.title = "레이블"
        insertField.backgroundColor = .white
        insertField.isTextingEnabled = false
        insertField.textAlignment = .right
        insertField.textColor = .gray
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.sizeToFit()
        insertField.rightButton = button
        return insertField
    }()
    
    let milestoneField: IssueInsertField = {
        let insertField = IssueInsertField()
        insertField.title = "마일스톤"
        insertField.backgroundColor = .white
        insertField.isTextingEnabled = false
        insertField.textAlignment = .right
        insertField.textColor = .gray
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.sizeToFit()
        insertField.rightButton = button
        return insertField
    }()

    let assigneeField: IssueInsertField = {
        let insertField = IssueInsertField()
        insertField.title = "담당자"
        insertField.backgroundColor = .white
        insertField.isTextingEnabled = false
        insertField.textAlignment = .right
        insertField.textColor = .gray
        
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.sizeToFit()
        insertField.rightButton = button
        return insertField
    }()
    
    private let formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        
        self.addSubview(formStackView)
        formStackView.addArrangedSubview(labelField)
        formStackView.addArrangedSubview(milestoneField)
        formStackView.addArrangedSubview(assigneeField)
        
        formStackView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
