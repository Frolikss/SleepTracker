//
//  SceneDelegate.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

private enum DefaultsNames: String {
    case isLaunchedBefore
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let isLaunchedBefore = UserDefaults.standard.bool(
            forKey: DefaultsNames.isLaunchedBefore.rawValue)

        if isLaunchedBefore {
            showMainScreen()
        } else {
            showOnboardingScreen()
        }

        window?.makeKeyAndVisible()
    }

    func showOnboardingScreen() {
        let onboardingViewController = OnboardingViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        window?.rootViewController = onboardingViewController

        UserDefaults.standard.set(true, forKey: DefaultsNames.isLaunchedBefore.rawValue)
    }

    func showMainScreen() {
        let mainViewController = AuthViewController()
        window?.rootViewController = mainViewController
    }
}
