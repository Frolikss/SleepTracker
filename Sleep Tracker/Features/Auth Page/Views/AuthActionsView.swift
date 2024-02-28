//
//  AuthActionsView.swift
//  Sleep Tracker
//
//  Created by Dima Y on 12.02.2024.
//

import UIKit

class AuthActionsView: UIView {
    private lazy var loginButton: UIButton = {
        let buttonConfig = getButtonConfiguration(title: "Log in", backgroudColor: .primary100)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var registerButton: UIButton = {
        let buttonConfig = getButtonConfiguration(
            title: "Create an account",
            backgroudColor: .grey95)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var guestButton: UIButton = {
        let buttonConfig = getButtonConfiguration(title: "Log in as a guest")

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension AuthActionsView {
    func setupLayout() {
        contentStackView.addArrangedSubview(loginButton)
        contentStackView.addArrangedSubview(registerButton)
        contentStackView.addArrangedSubview(guestButton)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            loginButton.heightAnchor.constraint(equalToConstant: 48.0),
            registerButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            guestButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor)
        ])
    }
}

// MARK: - Button Configurator
private extension AuthActionsView {
    func getButtonConfiguration(title: String, backgroudColor: UIColor = .clear) -> UIButton.Configuration {
        var buttonConfig = UIButton.Configuration.filled()

        buttonConfig.baseBackgroundColor = backgroudColor

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 16) ?? .systemFont(ofSize: 16)

        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])

        buttonConfig.attributedTitle = AttributedString(attributedTitle)

        return buttonConfig
    }
}

// MARK: - Actions
extension AuthActionsView {
    public func onLoginTapAction(action: UIAction) {
        loginButton.addAction(action, for: .touchUpInside)
    }

    public func onRegisterTapAction(action: UIAction) {
        registerButton.addAction(action, for: .touchUpInside)
    }
}
