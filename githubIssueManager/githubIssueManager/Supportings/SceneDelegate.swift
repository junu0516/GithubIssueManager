import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Log.debug("got UIWindowScene instance")
        
        self.appCoordinator = CoordinatorFactory.createCoordinator(type: AppCoordinator.self)
        Log.debug("created AppCoordinator")
        
        appCoordinator?.start()
        Log.debug("started AppCoordinator")
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appCoordinator?.navigationController
        Log.debug("set rootViewController as navigationController of AppCoordinator")
        
        self.window = window
        self.window?.makeKeyAndVisible()
        Log.debug("set UIWIndow visible")
    }
}

