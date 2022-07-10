import UIKit

extension UISegmentedControl {
    
    func valueSelected(action: @escaping (Int) -> Void ) {
        
        self.addAction(UIAction(handler: { [weak self] _ in
            action(self?.selectedSegmentIndex ?? 0)
        }), for: .valueChanged)
    }
}

