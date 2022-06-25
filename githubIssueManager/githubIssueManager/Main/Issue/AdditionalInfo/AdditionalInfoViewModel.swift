import Foundation

final class AdditionalInfoViewModel: BasicViewModel {
    
    struct Input {
        let titleValues = Observable<[TitleValuePossessible]>()
        let saveButtonTapped = Observable<Bool>()
        let cancelButtonTapped = Observable<Bool>()
    }
    
    struct Output {
        let infoViewModels = Observable<[AdditionalInfoTableViewCellModel]>()
    }
    
    let input = Input()
    let output = Output()
    
    private weak var navigation: IssueNavigation?
    
    init(titles: [TitleValuePossessible],
         navigation: IssueNavigation? = nil) {
        
        self.navigation = navigation
        bind(titles: titles)
    }
    
    private func bind(titles: [TitleValuePossessible]) {

        input.titleValues.value = titles

        input.titleValues.bind { [weak self] titles in
            self?.output.infoViewModels.value = titles.map { AdditionalInfoTableViewCellModel(title: $0.title) }
        }
        
        input.saveButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.navigation?.closeSelectView(selectedIndexList: self?.filterSelectedIndex() ?? [])
        }
        
        input.cancelButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.navigation?.closeSelectView(selectedIndexList: [])
        }
    }
    
    private func filterSelectedIndex() -> [Int] {
        guard let cellViewModels = output.infoViewModels.value else { return [] }
        
        return cellViewModels.enumerated()
                             .filter { (index, viewModel) -> Bool in
                                 return viewModel.output.isSelected.value ?? false
                             }
                             .map { $0.offset}
    }
}
