import Foundation

final class IssueListTableViewCellModel: BasicViewModel {
    struct Input {}
    struct Output {
        let title = Observable<String>()
        let issueDescription = Observable<String>()
        let milestone = Observable<String>()
    }
    
    let input = Input()
    let output = Output()
    
    init(issue: Issue) {
        self.output.title.value = issue.title
        self.output.issueDescription.value = issue.body ?? ""
        self.output.milestone.value = issue.milestone?.title ?? ""
    }
}
