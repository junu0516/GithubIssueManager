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
    
    convenience init(viewModel: LabelInsertViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttributes()
        
        cancelButton.tapped { [weak self] in
            self?.viewModel?.input.cancelButtonTapped.value = true
        }
    }
    
    private func setAttributes() {
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
}
