import Foundation

final class AdditionalInfoTableViewCellModel: BasicViewModel {
    
    struct Input {
        let isTouched = Observable<Bool>(false)
    }
    
    struct Output {
        let title = Observable<String>()
        let isSelected = Observable<Bool>()
    }
    
    let input = Input()
    let output = Output()
    
    init(title: String) {
        
        output.title.value = title
        
        input.isTouched.bind { [weak self] isTouched in
            self?.output.isSelected.value = isTouched
        }
    }
}
