import UIKit
import SnapKit

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
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    private let segmentView: UISegmentedControl = {
        let segmentView = UISegmentedControl(items: ["마크다운","미리보기"])
        segmentView.selectedSegmentIndex = 0
        return segmentView
    }()
    
    private let titleView: InsertField = {
        let insertField = InsertField()
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
            $0.height.equalToSuperview().multipliedBy(0.53)
        }
        
        view.addSubview(insertForm)
        insertForm.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
    private func setAttributes() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.titleView = segmentView
    }
}


