import Foundation

final class LabelListViewModel: BasicViewModel {

    struct Input{
        let labelListRequested = Observable<Bool>()
        let labels = Observable<[Label]>()
    }
    struct Output{
        let labelCellModels = Observable<[LabelListTableViewCellModel]>()
    }
    
    let input = Input()
    let output = Output()
    private let repository: LabelListRepository
    private weak var navigation: LabelNavigation?
    
    init(repository: LabelListRepository = LabelListRepository(),
         navigation: LabelNavigation? = nil) {
        
        self.repository = repository
        self.navigation = navigation
        
        bind()
    }
    
    private func bind() {
        
        input.labelListRequested.bind { [weak self] isRequested in
            guard isRequested == true else { return }
            self?.fetchLabelList()
        }
        
        input.labels.bind { [weak self] in
            self?.output.labelCellModels.value = $0.map { LabelListTableViewCellModel(label: $0) }
        }
    }
    
    private func fetchLabelList() {
        repository.requestLabels { [weak self] labels in
            self?.input.labels.value = labels
        }
    }
}
