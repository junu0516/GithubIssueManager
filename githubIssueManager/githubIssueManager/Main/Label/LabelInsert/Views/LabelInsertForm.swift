import UIKit
import SnapKit

class LabelInsertForm: UIView {
    
    let titleField: InsertField = {
        let insertField = InsertField()
        insertField.title = "제목"
        insertField.placeHolder = "필수입력"
        insertField.backgroundColor = .white
        return insertField
    }()
    
    let descriptionField: InsertField = {
        let insertField = InsertField()
        insertField.title = "설명"
        insertField.placeHolder = "선택사항"
        insertField.backgroundColor = .white
        return insertField
    }()
    
    let colorField: InsertField = {
        let insertField = InsertField()
        insertField.title = "배경색"
        insertField.backgroundColor = .white
        return insertField
    }()
    
    let colorChangeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.sizeToFit()
        return button
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
        setAttributes()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAttributes() {
        self.backgroundColor = .white
        self.colorField.rightButton = self.colorChangeButton
    }
    
    func addViews() {
        addSubview(formStackView)
        formStackView.addArrangedSubview(titleField)
        formStackView.addArrangedSubview(descriptionField)
        formStackView.addArrangedSubview(colorField)
        
        formStackView.snp.makeConstraints {
            $0.top.bottom.width.equalToSuperview()
        }
    }
    
}
