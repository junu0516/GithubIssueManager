import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?
    var deepLinkRouter: DeepLinkRouter?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Log.debug("got UIWindowScene instance")
        
        self.appCoordinator = CoordinatorFactory.createCoordinator(type: AppCoordinator.self)
        Log.debug("created AppCoordinator")
        
        appCoordinator?.start()
        Log.debug("started AppCoordinator")
        
        self.deepLinkRouter = DeepLinkRouter(appCoordinator: self.appCoordinator)
        Log.debug("created DeepLinkeRouter")

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = appCoordinator?.navigationController
        Log.debug("set rootViewController as navigationController of AppCoordinator")
        
        self.window = window
        self.window?.makeKeyAndVisible()
        Log.debug("set UIWIndow visible")
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        Log.debug("reopend with redirection link from github authentication request\n\(URLContexts)")
        guard let url = URLContexts.first?.url else { return }
        let authCode = url.description.components(separatedBy: "=").last ?? ""
        self.deepLinkRouter?.authCode.value = authCode
     }
}
