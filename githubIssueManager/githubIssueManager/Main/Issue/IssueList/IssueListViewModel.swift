import Foundation

final class IssueListViewModel: BasicViewModel {
    
    struct Input {
        let issueListRequested = Observable<Bool>()
        let issues = Observable<[Issue]>()
        let addButtonTapped = Observable<Bool>()
    }
    
    struct Output {
        let issueViewModels = Observable<[IssueListTableViewCellModel]>()
    }
    
    let input = Input()
    let output = Output()
    private let repository: IssueListRepository
    weak var navigation: IssueNavigation?
    
    init(repository: IssueListRepository = IssueListRepository(),
         navigation: IssueNavigation? = nil) {
        self.repository = repository
        self.navigation = navigation
        bind()
    }
    
    private func bind() {
        input.issueListRequested.bind { [weak self] isRequested in
            guard isRequested == true else { return }
            self?.fetchIssues()
        }
        
        input.issues.bind { [weak self] issues in
            self?.output.issueViewModels.value = issues.map { IssueListTableViewCellModel(issue: $0)}
        }
        
        input.addButtonTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            self?.navigation?.moveToIssueInsert()
        }
    }
    
    private func fetchIssues() {
        repository.requestIssues { [weak self] issues in
            self?.input.issues.value = issues
        }
    }
}
