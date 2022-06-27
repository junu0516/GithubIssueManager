import Foundation

final class LabelListTableViewCellModel: BasicViewModel {
    
    struct Input{}
    struct Output{
        let title = Observable<String>()
        let description = Observable<String>()
        let color = Observable<String>()
    }
    
    let input = Input()
    let output = Output()
    
    init(label: Label) {
        self.output.title.value = label.title
        self.output.description.value = label.description
        self.output.color.value = label.color
    }
}
