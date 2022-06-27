import UIKit

extension UITextField {
    
    func editted(action: @escaping (String?) -> Void ) {
        self.addAction(UIAction(handler: { [weak self] _ in
            action(self?.text)
        }), for: .editingChanged)
    }
}
