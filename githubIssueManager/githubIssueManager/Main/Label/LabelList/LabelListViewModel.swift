import Foundation

final class LabelListViewModel: BasicViewModel {

    struct Input{
        let labels = Observable<[Label]>()
    }
    struct Output{
        let labelCellModels = Observable<[LabelListTableViewCellModel]>()
    }
    
    let input = Input()
    let output = Output()
    private weak var navigation: LabelNavigation?
    
    init(navigation: LabelNavigation? = nil) {
        
        bind()
    }
    
    private func bind() {
        
        input.labels.bind { [weak self] in
            self?.output.labelCellModels.value = $0.map { LabelListTableViewCellModel(label: $0) }
        }
    }
    
}
