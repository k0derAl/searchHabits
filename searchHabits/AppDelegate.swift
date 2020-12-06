

import UIKit
#if DEBUG
    import DBDebugToolkit
    import AlamofireNetworkActivityLogger
#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        DI.initDependencies(self)
        #if DEBUG
            NetworkActivityLogger.shared.level = .debug
            NetworkActivityLogger.shared.startLogging()
            let tapTrigger = DBTapTrigger(numberOfTouchesRequired: 3)
            let longPressTrigger = DBLongPressTrigger(minimumPressDuration: 1.0)
            let shakeTrigger = DBShakeTrigger()
            DBDebugToolkit.setup(with: [tapTrigger, longPressTrigger, shakeTrigger])
        
        #endif
        configureRootViewController()
        return true
    }
    
    private func configureRootViewController() {
        let viewController = TabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }
}

