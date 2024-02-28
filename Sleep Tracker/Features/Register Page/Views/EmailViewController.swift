//
//  EmailViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 28.02.2024.
//

import UIKit

class EmailViewController: UIViewController {

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

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 24

        return stackView
    }()

    override func loadView() {
        super.loadView()
        setupLayout()
    }
}

// MARK: - Setup Layout && UI
private extension EmailViewController {
    func setupLayout() {
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(emailTextView)
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
}

// MARK: - Actions
extension EmailViewController: NextViewController {
    public func setNextButtonAction(action: UIAction) {
        self.nextButton.addAction(action, for: .touchUpInside)
    }
}
