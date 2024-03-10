//
//  SceneDelegate.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit
import KeychainAccess

private enum DefaultsNames: String {
    case isLaunchedBefore
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let keychainManager = Keychain(service: ApiConstants.bundleName)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        let isLaunchedBefore = UserDefaults.standard.bool(
            forKey: DefaultsNames.isLaunchedBefore.rawValue)

        if isLaunchedBefore {
            checkAuthentication()
        } else {
            showOnboardingScreen()
        }

        window?.makeKeyAndVisible()
    }

    private func showHomePage() {
        let homePageViewController = HomePageController()
        let navigationController = UINavigationController(rootViewController: homePageViewController)

        let appearence = UINavigationBarAppearance()

        appearence.configureWithOpaqueBackground()

        navigationController.navigationBar.backgroundColor = .red
        navigationController.navigationBar.standardAppearance = appearence
        navigationController.navigationBar.scrollEdgeAppearance = appearence
        navigationController.navigationBar.compactAppearance = appearence

        window?.rootViewController = navigationController
    }

    private func showOnboardingScreen() {
        let onboardingViewController = OnboardingViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)

        window?.rootViewController = onboardingViewController

        UserDefaults.standard.set(true, forKey: DefaultsNames.isLaunchedBefore.rawValue)
    }

    private func showLoginScreen() {
        let mainViewController = AuthViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)

        navigationController.navigationBar.isHidden = true

        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .grey100
        appearence.titleTextAttributes = [
            .font: UIFont(name: Fonts.ralewayBold.rawValue, size: 14.0) ?? .systemFont(ofSize: 14.0),
            .foregroundColor: UIColor.white
        ]

        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = appearence
        navigationController.navigationBar.scrollEdgeAppearance = appearence
        navigationController.navigationBar.compactAppearance = appearence

        window?.rootViewController = navigationController
    }

    public func checkAuthentication() {
        UserManager.shared.getSelf { [weak self] user in
            guard let self, user != nil else {
                self?.showLoginScreen()
                return
            }

            showHomePage()
            window?.makeKeyAndVisible()
        }
    }
}
