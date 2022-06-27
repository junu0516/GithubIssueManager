import Foundation

final class LabelListTableViewCellModel: BasicViewModel {
    
    struct Input{}
    struct Output{
        let title = Observable<String>()
    }
    
    let input = Input()
    let output = Output()
    
    init(label: Label) {
        self.output.title.value = label.title
    }
}
