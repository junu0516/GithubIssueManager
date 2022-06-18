import UIKit

extension UIButton {
    
    func tapped(action: @escaping ()->Void ) {
        self.addAction(UIAction(handler: { _ in
            action()
        }), for: .touchDown)
    }
}
