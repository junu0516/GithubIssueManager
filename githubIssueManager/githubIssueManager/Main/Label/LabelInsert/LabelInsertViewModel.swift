import Foundation

final class LabelInsertViewModel: BasicViewModel {
    
    struct Input {
        let cancelButtonTapped = Observable<Bool>()
        let colorChangeButtonTapped = Observable<Bool>()
    }
    struct Output {
        let labelColor = Observable<String>()
    }
    
    let input = Input()
    let output = Output()
    
    private weak var navigation: LabelNavigation?
    private var randomColor: String {
        return (0..<3).map { _ in String(format: "%02X", Int.random(in: 0...255)) }.joined()
    }
    
    init(navigation: LabelNavigation? = nil) {
        self.navigation = navigation
        
        bind()
    }
    
    private func bind() {
        
        output.labelColor.value = randomColor
        
        input.cancelButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.navigation?.goBackToLabelList()
        }
        
        input.colorChangeButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.output.labelColor.value = self?.randomColor
        }
    }
}
