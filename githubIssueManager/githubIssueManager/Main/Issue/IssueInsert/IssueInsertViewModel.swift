import Foundation

final class IssueInsertViewModel: BasicViewModel {
    
    struct Input {
        let repoInfoRequested = Observable<Bool>()
        let milestones = Observable<[Milestone]>()
        let labels = Observable<[Label]>()
        let assignees = Observable<[Assignee]>()
        let saveButtonTapped = Observable<Bool>()
        let labelFieldTapped = Observable<Bool>()
        let milestoneFieldTapped = Observable<Bool>()
        let assigneeFieldTapped = Observable<Bool>()
    }
    
    struct Output {
        let selectedMilestones = Observable<[Milestone]>()
        let selectedLabels = Observable<[Label]>()
        let selectedAssignees = Observable<[Assignee]>()
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
        
        input.milestoneFieldTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let milestones = self?.input.milestones.value ?? []
            self?.navigation?.showInfoSelectView(models: milestones) { selectedIndexList in
                self?.saveSelectedInfo(infoType: .milestone, selectedIndexList: selectedIndexList)
            }
        }
        
        input.labelFieldTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let labels = self?.input.labels.value ?? []
            self?.navigation?.showInfoSelectView(models: labels) { selectedIndexList in
                self?.saveSelectedInfo(infoType: .label, selectedIndexList: selectedIndexList)
            }
        }
        
        input.assigneeFieldTapped.bind { [weak self] isTapped in
            guard isTapped == true else { return }
            let assignees = self?.input.assignees.value ?? []
            self?.navigation?.showInfoSelectView(models: assignees) { selectedIndexList in
                self?.saveSelectedInfo(infoType: .assignee, selectedIndexList: selectedIndexList)
            }
        }
    }
    
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
    
    private func saveSelectedInfo(infoType:InfoType, selectedIndexList: [Int]) {
        
        switch infoType {
        case .milestone:
            updateSelectedMilestones(selectedIndexList: selectedIndexList)
        case .label:
            updateSelectedLabels(selectedIndexList: selectedIndexList)
        case .assignee:
            updateSelectedAssignees(selectedIndexList: selectedIndexList)
        }
    }
}

extension IssueInsertViewModel {
    
    private enum InfoType {
        case milestone
        case label
        case assignee
    }

    private func updateSelectedMilestones(selectedIndexList: [Int]) {
        guard let milestones = input.milestones.value else { return }
        let selected = selectedIndexList.map { milestones[$0] }
        output.selectedMilestones.value = selected
    }
    
    private func updateSelectedLabels(selectedIndexList: [Int]) {
        guard let labels = input.labels.value else { return }
        let selected = selectedIndexList.map { labels[$0] }
        output.selectedLabels.value = selected
    }
    
    private func updateSelectedAssignees(selectedIndexList: [Int]) {
        guard let assignees = input.assignees.value else { return }
        let selected = selectedIndexList.map { assignees[$0] }
        output.selectedAssignees.value = selected
    }
}
