import UIKit
import SnapKit
import SwiftyMarkdown

final class IssueInsertViewController: UIViewController {
    
    private var viewModel: IssueInsertViewModel?
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.titleLabel?.textAlignment = .left
        return button
    }()
    
    private let textViewDelegate = TextViewDelegate()
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.delegate = textViewDelegate
        return textView
    }()
    
    private let previewView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .darkGray
        textView.textColor = .black
        textView.isHidden = true
        textView.isEditable = false
        return textView
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 정보"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.sizeToFit()
        label.numberOfLines = 1
        return label
    }()
    
    private let segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["마크다운","미리보기"])
        segmentView.selectedSegmentIndex = 0
        return segmentView
    }()
    
    private let titleView: IssueInsertField = {
        let insertField = IssueInsertField()
        insertField.title = "제목"
        insertField.placeHolder = "제목을 입력하세요"
        insertField.backgroundColor = .white
        return insertField
    }()
    
    private let insertForm: IssueInsertForm = {
        let insertForm = IssueInsertForm()
        insertForm.backgroundColor = .systemBackground
        return insertForm
    }()
    
    convenience init(viewModel: IssueInsertViewModel) {
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
        viewModel?.input.repoInfoRequested.value = true
        
        insertForm.milestoneField.tapped { [weak self] in
            self?.viewModel?.input.milestoneFieldTapped.value = true
        }
        
        insertForm.labelField.tapped { [weak self] in
            self?.viewModel?.input.labelFieldTapped.value = true
        }
        
        insertForm.assigneeField.tapped { [weak self] in
            self?.viewModel?.input.assigneeFieldTapped.value = true
        }
        
        viewModel?.output.selectedLabels.bind { [weak self] labels in
            let text = labels.reduce(""){ $0 + ", " + $1.title }
            self?.insertForm.labelField.text = String(text.dropFirst())
        }
        
        viewModel?.output.selectedAssignees.bind { [weak self] assignees in
            let text = assignees.reduce(""){ $0 + ", " + $1.title }
            self?.insertForm.assigneeField.text = String(text.dropFirst())
        }
        
        viewModel?.output.selectedMilestones.bind { [weak self] milestones in
            let text = milestones.reduce(""){ $0 + ", " + $1.title }
            self?.insertForm.milestoneField.text = String(text.dropFirst())
        }
        
        viewModel?.output.issueInsertResult.bind { [weak self] insertResult in
            guard insertResult == true else { return }
            self?.viewModel?.input.closingViewRequested.value = true
        }
        
        viewModel?.output.markdownPreview.bind { [weak self] previewFlag in
            self?.textView.isHidden = previewFlag
            self?.previewView.isHidden = !previewFlag
        }
        
        saveButton.tapped { [weak self] in
            self?.viewModel?.input.saveButtonTapped.value = true
        }
        
        textViewDelegate.updatedText.bind { [weak self] text in
            self?.viewModel?.input.bodyUpdated.value = text
            self?.previewView.attributedText = SwiftyMarkdown(string: text).attributedString()
        }
        
        titleView.editted { [weak self] text in
            self?.viewModel?.input.titleUpdated.value = text
        }
        
        segmentView.valueSelected { [weak self] index in
            self?.viewModel?.input.segmentIndexSelected.value = index
        }
    }
    
    private func addViews() {
        
        view.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalToSuperview().multipliedBy(0.43)
        }
        
        view.addSubview(previewView)
        textView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalToSuperview().multipliedBy(0.43)
        }
        
        view.addSubview(insertForm)
        insertForm.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
        
        view.addSubview(additionalInfoLabel)
        additionalInfoLabel.snp.makeConstraints {
            $0.bottom.equalTo(insertForm.snp.top)
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalToSuperview().multipliedBy(0.07)
        }
    }
    
    private func setAttributes() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.titleView = segmentView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
