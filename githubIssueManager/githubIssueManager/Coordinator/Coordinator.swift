import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController? { get }
    
    init()

    func start()
}
