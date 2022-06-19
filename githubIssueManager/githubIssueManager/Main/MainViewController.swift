import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    private var viewModel: MainViewModel?
    
    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
    }
}

final class MainViewModel: BasicViewModel {
    
    struct Input {}
    struct Output {}
    
    let input = Input()
    let output = Output()
}
