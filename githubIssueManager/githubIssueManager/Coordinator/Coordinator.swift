import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    init()

    func start()
}

extension Coordinator {
    
    func addCoordinator(_ child: Coordinator) {
        childCoordinators.append(child)
    }
    
    func removeCoordinator(_ child: Coordinator) {
        guard childCoordinators.isEmpty == false else { return }
        
        for (index, coordinator) in childCoordinators.enumerated() {
            if(coordinator === child) {
                childCoordinators.remove(at: index)
                return
            }
        }
    }
}
