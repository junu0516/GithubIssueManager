import UIKit
import SnapKit

class LabelInsertForm: UIView {
    
    let titleField: InsertField = {
        let form = InsertField()
        form.title = "제목"
        form.placeHolder = "필수입력"
        form.backgroundColor = .white
        return form
    }()
    
    let descriptionField: InsertField = {
        let form = InsertField()
        form.title = "설명"
        form.placeHolder = "선택사항"
        form.backgroundColor = .white
        return form
    }()
    
    let colorField: InsertField = {
        let form = InsertField()
        form.title = "배경색"
        form.backgroundColor = .white
        return form
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
