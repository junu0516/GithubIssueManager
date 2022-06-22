import Foundation

final class IssueListViewModel: BasicViewModel {
    
    struct Input {
        let issueListRequested = Observable<Bool>()
        let issues = Observable<[Issue]>()
    }
    
    struct Output {
        let issueViewModels = Observable<[IssueListTableViewCellModel]>()
    }
    
    let input = Input()
    let output = Output()
    private let repository: IssueListRepository
    
    init(repository: IssueListRepository = IssueListRepository()) {
        self.repository = repository
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
    }
    
    private func fetchIssues() {
        repository.requestIssues { [weak self] issues in
            self?.input.issues.value = issues
        }
    }
}