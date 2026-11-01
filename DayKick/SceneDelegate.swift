//
//  SceneDelegate.swift
//  Daykick
//
//  Sets the app's root view controller in code.
//
//  SHARED FILE
//
//  Changed by Kevin Lim on 10/31/26: sets a UINavigationController with HomeViewController as the root instead of loading Main.storyboard.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        makeNavBar(activeScene: windowScene)
    }

    // used for making tabs in the nav bar
    func makeTab(root: UIViewController, title: String, icon: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: root)
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.tintColor = Theme.accentColor
        nav.tabBarItem = UITabBarItem(title: title,
                                      image: UIImage(systemName: icon),
                                      selectedImage: UIImage(systemName: "\(icon).fill"))
        return nav
    }

    func makeNavBar(activeScene: UIWindowScene) {
        let homeNav = makeTab(root: HomeViewController(), title: "Home", icon: "house")
        let historyNav = makeTab(root: HistoryViewController(), title: "History", icon: "clock")
        let remindersNav = makeTab(root: RemindersViewController(), title: "Reminders", icon: "bell")

        // This is main navigation bar, it's what connects our screens/tabs
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([homeNav, historyNav, remindersNav], animated: false)
        tabBarController.tabBar.tintColor = Theme.accentColor

        let win = UIWindow(windowScene: activeScene)
        win.rootViewController = tabBarController
        self.window = win
        win.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
