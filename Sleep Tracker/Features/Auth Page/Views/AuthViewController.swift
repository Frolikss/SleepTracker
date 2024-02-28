//
//  AuthViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

class AuthViewController: UIViewController {
    private let logoView = LogoView()
    private let actionsView = AuthActionsView()
    private let thirdPatyAuthView = AuthThirdPartyView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 32

        return stackView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func loadView() {
        super.loadView()
        setupUI()
        setupActions()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension AuthViewController {
    func setupLayout() {
        contentStackView.addArrangedSubview(logoView)
        contentStackView.addArrangedSubview(actionsView)
        contentStackView.addArrangedSubview(thirdPatyAuthView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            contentStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
        ])
    }

    func setupUI() {
        self.view.backgroundColor = .grey100
    }
}

// MARK: - Actions
private extension AuthViewController {
    func setupActions() {
        let loginAction = UIAction { _ in
            let loginViewController = LoginViewController()

            self.navigationController?.pushViewController(loginViewController, animated: true)
        }

        let registerAction = UIAction { _ in
            let registerViewController = RegisterViewController()

            self.navigationController?.pushViewController(registerViewController, animated: true)
        }

        actionsView.onLoginTapAction(action: loginAction)
        actionsView.onRegisterTapAction(action: registerAction)
    }
}
