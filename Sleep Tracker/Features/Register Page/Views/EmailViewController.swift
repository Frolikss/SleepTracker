//
//  EmailViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 28.02.2024.
//

import UIKit
import Combine

class EmailViewController: UIViewController {
    private var registerViewModel: RegisterViewModel

    private var cancellables = Set<AnyCancellable>()

    private let emailTextView = TextFieldWithLabel(title: "Email address", placeholder: "examplemail@gmail.com", keyboardType: .emailAddress)

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

    private lazy var emailErrorLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 14)
        label.textColor = .red
        label.isHidden = true

        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 24

        return stackView
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
private extension EmailViewController {
    func setupLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(emailTextView)
        contentStackView.addArrangedSubview(emailErrorLabel)
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
        nextButton.isEnabled = false
    }
}

// MARK: - NextViewController Protocol
extension EmailViewController: NextViewController {
    public func setNextButtonAction(action: UIAction) {
        self.nextButton.addAction(action, for: .touchUpInside)
    }
}

// MARK: Subscriptions
private extension EmailViewController {
    func setupFieldsSubscriptions() {
        let emailTextField = emailTextView.getTextField()
        emailTextField.autocapitalizationType = .none

        NotificationCenter.default
            .publisher(
                for: UITextField.textDidChangeNotification,
                object: emailTextField)
            .debounce(for: 0.4, scheduler: DispatchQueue.main)
            .compactMap { ($0.object as? UITextField)?.text }
            .sink { [weak self] email in
                guard let self else { return }
                registerViewModel.setEmail(email)
            }
            .store(in: &cancellables)
    }

    func setupValidationsSubscriptions() {
        let isCorrectEmail = registerViewModel.getIsCorrectEmail()

        isCorrectEmail
            .dropFirst()
            .sink { [weak self] isCorrect in
                guard let self else { return }
                emailTextView.setIsValidated(with: isCorrect)

                if !isCorrect {
                    emailErrorLabel.isHidden = false
                    emailErrorLabel.text = ValidationErrors.email.rawValue
                } else {
                    emailErrorLabel.isHidden = true
                    nextButton.isEnabled = isCorrect
                }
            }
            .store(in: &cancellables)
    }
}
