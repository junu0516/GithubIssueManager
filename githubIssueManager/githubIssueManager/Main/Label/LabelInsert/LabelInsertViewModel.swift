import Foundation

final class LabelInsertViewModel: BasicViewModel {
    
    struct Input {
        let cancelButtonTapped = Observable<Bool>()
        let colorChangeButtonTapped = Observable<Bool>()
        let titleUpdated = Observable<String>()
        let descriptionUpdated = Observable<String>()
        let saveButtonTapped = Observable<Bool>()
    }
    struct Output {
        let labelColor = Observable<String>()
        let labelTitle = Observable<String>()
        let labelDescription = Observable<String>()
        let isTitleEmpty = Observable<Bool>(true)
    }
    
    let input = Input()
    let output = Output()
    
    private weak var navigation: LabelNavigation?
    private let repository: LabelInsertRepository
    private var randomColor: String {
        return (0..<3).map { _ in String(format: "%02X", Int.random(in: 0...255)) }.joined()
    }
    
    init(navigation: LabelNavigation? = nil,
         repository: LabelInsertRepository = LabelInsertRepository()) {
        self.navigation = navigation
        self.repository = repository
        
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
        
        input.titleUpdated.bind { [weak self] title in
            self?.output.labelTitle.value = title
            self?.output.isTitleEmpty.value = title.isEmpty
        }
        
        input.descriptionUpdated.bind { [weak self] description in
            self?.output.labelDescription.value = description
        }
        
        input.saveButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.requestAddingLabel()
        }
    }
    
    private func requestAddingLabel() {
        guard let title = output.labelTitle.value else { return }
        let description = output.labelDescription.value
        let color = output.labelColor.value
        let labelRequest = Label(title: title, description: description, color: color)
        
        repository.requestAddingLabel(label: labelRequest) { [weak self] in
            self?.navigation?.goBackToLabelList()
        }
    }
}
