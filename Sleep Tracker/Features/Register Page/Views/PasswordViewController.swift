//
//  PasswordViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 28.02.2024.
//

import UIKit
import Combine

class PasswordViewController: UIViewController {
    private var registerViewModel: RegisterViewModel
    private var cancellables = Set<AnyCancellable>()

    private let passwordTextView = TextFieldWithLabel(title: "Create a password", placeholder: "Password")

    private lazy var nextButton: UIButton = {
        var buttonConfig = UIButton.Configuration.filled()

        buttonConfig.baseBackgroundColor = .primary100

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 16) ?? .systemFont(ofSize: 16)

        let attributedTitle = NSAttributedString(string: "Next", attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])

        buttonConfig.attributedTitle = AttributedString(attributedTitle)

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 24

        return stackView
    }()

    private lazy var passwordErrorLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 14)
        label.textColor = .red
        label.isHidden = true

        return label
    }()

    init(registerViewModel: RegisterViewModel) {
        self.registerViewModel = registerViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setupUI()
        setupLayout()
        setupFieldsSubscriptions()
        setupValidationsSubscriptions()
    }
}

// MARK: - Setup Layout && UI
private extension PasswordViewController {
    func setupLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(passwordTextView)
        contentStackView.addArrangedSubview(passwordErrorLabel)
        contentStackView.addArrangedSubview(nextButton)

        self.view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: self.view.topAnchor),
            contentStackView.leadingAnchor.constraint(
                equalTo: self.view.leadingAnchor, constant: 20.0),
            contentStackView.bottomAnchor.constraint(
                lessThanOrEqualTo: self.view.bottomAnchor),
            contentStackView.trailingAnchor.constraint(
                equalTo: self.view.trailingAnchor, constant: -20.0),

            nextButton.heightAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    func setupUI() {
        let passwordTextField = passwordTextView.getTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password

        nextButton.isEnabled = false
    }
}

// MARK: - NextViewController Protocol
extension PasswordViewController: NextViewController {
    public func setNextButtonAction(action: UIAction) {
        self.nextButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: Subscriptions
private extension PasswordViewController {
    func setupFieldsSubscriptions() {
        let passwordTextField = passwordTextView.getTextField()

        NotificationCenter
            .default
            .publisher(
                for: UITextField.textDidChangeNotification,
                object: passwordTextField)
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] password in
                guard let self else { return }
                registerViewModel.setPassword(password)
            }
            .store(in: &cancellables)
    }

    func setupValidationsSubscriptions() {
        let isCorrectPassword = registerViewModel.getIsCorrectPassword()

        isCorrectPassword
            .dropFirst()
            .sink { [weak self] isCorrect in
                guard let self else { return }
                passwordTextView.setIsValidated(with: isCorrect)

                if !isCorrect {
                    passwordErrorLabel.isHidden = false
                    passwordErrorLabel.text = ValidationErrors.password.rawValue
                } else {
                    passwordErrorLabel.isHidden = true
                    nextButton.isEnabled = isCorrect
                }
            }
            .store(in: &cancellables)
    }
}
