//
//  LoginViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 13.02.2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    private let loginViewModel = LoginViewModel()
    private var cancellables = Set<AnyCancellable>()

    private let logoView = LogoView(imageSize: CGSize(width: 56.0, height: 56.0))

    private let emailTextView = TextFieldWithLabel(
        title: "Email address",
        placeholder: "Email",
        keyboardType: .emailAddress)
    private let passwordTextView = TextFieldWithLabel(
        title: "Password",
        placeholder: "Password")

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

    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 14)
        label.textColor = .red
        label.isHidden = true

        return label
    }()

    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 14)
        label.textColor = .red
        label.isHidden = true

        return label
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

        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

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
        setupFieldsSubscriptions()
        setupValidationSubscriptions()
    }
}

// MARK: - Setup UI && Layout
private extension LoginViewController {
    func setupLayout() {
        textFieldsStackView.addArrangedSubview(emailTextView)
        textFieldsStackView.addArrangedSubview(emailErrorLabel)
        textFieldsStackView.addArrangedSubview(passwordTextView)
        textFieldsStackView.addArrangedSubview(passwordErrorLabel)
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
        self.view.backgroundColor = .grey100

        let emailTextField = emailTextView.getTextField()
        emailTextField.autocapitalizationType = .none

        let passwordTextFIeld = passwordTextView.getTextField()
        passwordTextFIeld.isSecureTextEntry = true
        passwordTextFIeld.textContentType = .password
    }
}

// MARK: - Setup Subscriptions
private extension LoginViewController {
    func setupFieldsSubscriptions() {
        let emailTextField = emailTextView.getTextField()
        let passwordTextField = passwordTextView.getTextField()

        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
            .debounce(for: 0.7, scheduler: DispatchQueue.main)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] email in
                guard let self else { return }
                loginViewModel.setEmail(email)
            }
            .store(in: &cancellables)

        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .debounce(for: 0.7, scheduler: DispatchQueue.main)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] password in
                guard let self else { return }
                loginViewModel.setPassword(password)
            }
            .store(in: &cancellables)
    }

    func setupValidationSubscriptions() {
        let isCorrectEmail = loginViewModel.getIsCorrectEmail()
        isCorrectEmail
            .dropFirst()
            .sink { [weak self] isCorrect in
                guard let self else { return }

                emailTextView.setIsValidated(with: isCorrect)

                if !isCorrect {
                    emailErrorLabel.isHidden = false
                    emailErrorLabel.text = "Email format is incorrect"
                } else {
                    emailErrorLabel.isHidden = true
                }
            }
            .store(in: &cancellables)

        let isCorrectPassword = loginViewModel.getIsCorrectPassword()
        isCorrectPassword
            .dropFirst()
            .sink { [weak self] isCorrect in
                guard let self else { return }

                passwordTextView.setIsValidated(with: isCorrect)

                if !isCorrect {
                    passwordErrorLabel.isHidden = false
                    passwordErrorLabel.text = "Password format is incorrect"
                } else {
                    passwordErrorLabel.isHidden = true
                }
            }
            .store(in: &cancellables)

        let isLoginEnabled = loginViewModel.getIsLoginEnabled()
        isLoginEnabled
            .sink { [weak self] isCorrect in
                guard let self else { return }
                loginButton.isEnabled = isCorrect
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
private extension LoginViewController {
    @objc func didTapLoginButton() {
        loginViewModel.submitLogin()
    }
}
