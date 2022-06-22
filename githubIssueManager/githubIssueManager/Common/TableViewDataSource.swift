import UIKit

final class TableViewDataSource<Cell: TableViewCell, Model>: NSObject, UITableViewDataSource {
    
    private let cellIdentifier : String
    private var models : [Model]?
    var configureCell : (Cell, Model) -> ()
    
    var items: [Model]? {
        didSet {
            models = items
        }
    }
    
    init(models : [Model], configureCell : @escaping (Cell, Model) -> ()) {
        self.cellIdentifier = Cell.identifier
        self.models = models
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell,
              let model = models?[indexPath.row] else {
            return TableViewCell()
        }
        
        configureCell(cell, model)
        return cell
    }
}
