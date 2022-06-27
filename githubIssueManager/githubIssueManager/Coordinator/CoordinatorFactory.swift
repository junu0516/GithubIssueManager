import Foundation

protocol CoordinatorFactoryApplicable {
    
    static func create<T:Coordinator>(type: T.Type) -> Coordinator?
}

final class CoordinatorFactory: CoordinatorFactoryApplicable {
    
    private static let coordinatorType: [ObjectIdentifier:Coordinator.Type] = [
        ObjectIdentifier(AppCoordinator.self): AppCoordinator.self,
        ObjectIdentifier(LoginCoordinator.self): LoginCoordinator.self,
        ObjectIdentifier(MainCoordinator.self): MainCoordinator.self,
        ObjectIdentifier(IssueCoordinator.self): IssueCoordinator.self,
        ObjectIdentifier(LabelCoordinator.self): LabelCoordinator.self
    ]
        
    static func create<T:Coordinator>(type: T.Type) -> Coordinator? {
        guard let coordinator = coordinatorType[ObjectIdentifier(type)] else { return nil }

        return coordinator.init()
    }
}
