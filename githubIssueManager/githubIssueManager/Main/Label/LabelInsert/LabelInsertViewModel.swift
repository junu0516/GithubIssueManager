import Foundation

final class LabelInsertViewModel: BasicViewModel {
    
    struct Input {
        let cancelButtonTapped = Observable<Bool>()
    }
    struct Output {}
    
    let input = Input()
    let output = Output()
    
    private weak var navigation: LabelNavigation?
    
    init(navigation: LabelNavigation? = nil) {
        self.navigation = navigation
        
        bind()
    }
    
    private func bind() {
        
        input.cancelButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.navigation?.goBackToLabelList()
        }
    }
}
