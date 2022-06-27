import UIKit
import SnapKit

final class LabelInsertViewController: UIViewController {
    
    private var viewModel: LabelInsertViewModel?
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let insertForm: LabelInsertForm = {
        let insertForm = LabelInsertForm()
        return insertForm
    }()
    
    private let labelBox: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let previewLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.padding = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.sizeToFit()
        return label
    }()
    
    convenience init(viewModel: LabelInsertViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        addViews()
        bind()
    }
    
    private func bind() {
        
        cancelButton.tapped { [weak self] in
            self?.viewModel?.input.cancelButtonTapped.value = true
        }
        
        insertForm.colorChangeButton.tapped { [weak self] in
            self?.viewModel?.input.colorChangeButtonTapped.value = true
        }

        insertForm.titleField.editted { [weak self] text in
            self?.viewModel?.input.titleUpdated.value = text
        }
        
        insertForm.descriptionField.editted { [weak self] text in
            self?.viewModel?.input.descriptionUpdated.value = text
        }
        
        viewModel?.output.labelColor.bind { [weak self] color in
            self?.insertForm.colorField.text = "#\(color)"
            self?.previewLabel.backgroundColor = color.hexToColor()
            self?.previewLabel.textColor = color.hexToColor().contrast
        }
        
        viewModel?.output.labelTitle.bind { [weak self] title in
            self?.previewLabel.text = title
        }
    }
    
    private func addViews() {
        
        view.addSubview(insertForm)
        insertForm.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.width.equalToSuperview()
        }

        view.addSubview(labelBox)
        labelBox.snp.makeConstraints {
            $0.top.equalTo(insertForm.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.3)
        }

        labelBox.addSubview(previewLabel)
        previewLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(labelBox)
            $0.height.equalTo(labelBox).multipliedBy(0.13)
        }
    }
    
    private func setAttributes() {
        
        view.backgroundColor = .systemGray6
        navigationItem.title = "추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
}
