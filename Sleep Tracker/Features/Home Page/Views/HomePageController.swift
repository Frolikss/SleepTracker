//
//  HomePageController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 27.02.2024.
//

import UIKit
import KeychainAccess

class HomePageController: UIViewController {
    private let keychainManager = Keychain(service: ApiConstants.bundleName)

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()

        button.setTitle("Logout", for: .normal)
        button.addAction(UIAction(handler: { [weak self] _ in
            try? self?.keychainManager.remove(ApiConstants.accessToken)
        }), for: .touchUpInside)
        self.view.addSubview(button)

        self.view.backgroundColor = .grey20

        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
