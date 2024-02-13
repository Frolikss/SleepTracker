//
//  LoginViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 13.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    public let logoView = LogoView(imageSize: CGSize(width: 56.0, height: 56.0))

    private let emailTextField = TextFieldWithLabel(title: "Email address", placeholder: "Email")
    private let passwordTextField = TextFieldWithLabel(title: "Password", placeholder: "Password")

    private lazy var forgotPasswordButton: UIButton = {
        var buttonConfig = UIButton.Configuration.plain()

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 12) ?? .systemFont(ofSize: 12)

        let attributedTitle = NSAttributedString(string: "Forgot password?", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.grey20
        ])

        buttonConfig.attributedTitle = AttributedString(attributedTitle)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var loginButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 16) ?? .systemFont(ofSize: 16)

        let attributedTitle = NSAttributedString(string: "Log in", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])

        buttonConfig.attributedTitle = AttributedString(attributedTitle)
        buttonConfig.baseBackgroundColor = .primary100

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 24

        return stackView
    }()

    override func loadView() {
        super.loadView()
        setupUI()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension LoginViewController {
    func setupLayout() {
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(forgotPasswordButton)

        contentStackView.addArrangedSubview(logoView)
        contentStackView.addArrangedSubview(textFieldsStackView)
        contentStackView.addArrangedSubview(loginButton)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                constant: 32.0),
            contentStackView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0),
            contentStackView.trailingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0),

            loginButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    func setupUI() {
        emailTextField.setupDelegate(delegate: self)
        passwordTextField.setupDelegate(delegate: self)
    }
}

// MARK: - UITextField Delegate
extension LoginViewController: UITextFieldDelegate {

}
