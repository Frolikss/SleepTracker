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

    override func loadView() {
        super.loadView()
        setupUI()
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
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8.0),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8.0)
        ])
    }

    func setupUI() {
        self.view.backgroundColor = .grey100
    }
}
