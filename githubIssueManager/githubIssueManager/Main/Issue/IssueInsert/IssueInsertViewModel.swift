import Foundation

final class IssueInsertViewModel: BasicViewModel {
    
    struct Input {
        let repoInfoRequested = Observable<Bool>()
        let milestones = Observable<[Milestone]>()
        let labels = Observable<[Label]>()
        let assignees = Observable<[Assignee]>()
    }
    
    struct Output {
        let milestones = Observable<[Milestone]>()
        let labels = Observable<[Label]>()
        let assignees = Observable<[Assignee]>()
    }
    
    let input = Input()
    let output = Output()
    private let repository: IssueInsertRepository
    private weak var navigation: IssueNavigation?
    
    init(repository: IssueInsertRepository = IssueInsertRepository(),
         navigation: IssueNavigation? = nil) {
        self.repository = repository
        self.navigation = navigation
        bind()
    }
    
    private func bind() {
        input.repoInfoRequested.bind { [weak self] isRequested in
            guard isRequested == true else { return }
            DispatchQueue.global(qos: .background).sync {
                self?.fetchRepoInfo()
            }
        }
        
        input.milestones.bind { [weak self] milestones in
            self?.output.milestones.value = milestones
        }
        
        input.labels.bind { [weak self] labels in
            self?.output.labels.value = labels
        }
        
        input.assignees.bind { [weak self] assignees in
            self?.output.assignees.value = assignees
        }
    }
    
    //담당자, 라벨, 마일스톤 리스트 요청
    private func fetchRepoInfo() {
        repository.requestLabels { [weak self] labels in
            self?.input.labels.value = labels
        }
        
        repository.requestMilestones { [weak self] milestones in
            self?.input.milestones.value = milestones
        }
        
        repository.requestAssignees { [weak self] assignees in
            self?.input.assignees.value = assignees
        }
    }
}
