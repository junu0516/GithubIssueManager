import Foundation

final class IssueInsertViewModel: BasicViewModel {
    
    struct Input {
        let repoInfoRequested = Observable<Bool>()
        let milestones = Observable<[Milestone]>()
        let labels = Observable<[Label]>()
        let assignees = Observable<[Assignee]>()
        let saveButtonTapped = Observable<Bool>()
        let labelFieldTapped = Observable<Bool>()
        let milestoneFiledTapped = Observable<Bool>()
        let assigneeFiledTapped = Observable<Bool>()
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
        
        input.milestoneFiledTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let milestones = self?.output.milestones.value ?? []
            self?.navigation?.showInfoSelectView(models: milestones) { selectedIndexList in
                self?.saveSelectedInfo(selectedIndexList: selectedIndexList)
            }
        }
        
        input.labelFieldTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let labels = self?.output.labels.value ?? []
            self?.navigation?.showInfoSelectView(models: labels) { selectedIndexList in
                self?.saveSelectedInfo(selectedIndexList: selectedIndexList)
            }
        }
        
        input.assigneeFiledTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let assignees = self?.output.assignees.value ?? []
            self?.navigation?.showInfoSelectView(models: assignees) { selectedIndexList in
                self?.saveSelectedInfo(selectedIndexList: selectedIndexList)
            }
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
    
    private func saveSelectedInfo(selectedIndexList: [Int]) {
        Log.debug("selected index : \(selectedIndexList)")
    }
}
