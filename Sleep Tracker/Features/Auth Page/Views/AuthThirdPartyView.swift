//
//  AuthThirdPartyView.swift
//  Sleep Tracker
//
//  Created by Dima Y on 12.02.2024.
//

import UIKit

class AuthThirdPartyView: UIView {
    private let divider = OrDivider()

    private lazy var googleButton: UIButton = {
        let buttonConfig = getButtonConfiguration(title: "Continue with Google", imageName: "google-logo")

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var facebookButton: UIButton = {
        let buttonConfig = getButtonConfiguration(title: "Continue with Facebook", imageName: "facebook-logo")

        let button = UIButton(configuration: buttonConfig)

        return button
    }()

    private lazy var appleButton: UIButton = {
        let buttonConfig = getButtonConfiguration(title: "Continue with Apple", imageName: "apple-logo")

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
        setupUI()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension AuthThirdPartyView {
    func setupLayout() {
        contentStackView.addArrangedSubview(divider)
        contentStackView.addArrangedSubview(googleButton)
        contentStackView.addArrangedSubview(facebookButton)
        contentStackView.addArrangedSubview(appleButton)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            googleButton.heightAnchor.constraint(equalToConstant: 48.0),
            facebookButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor),
            appleButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor)
        ])
    }

    func setupUI() {
        applyBorderStylesToButton(googleButton)
        applyBorderStylesToButton(facebookButton)
        applyBorderStylesToButton(appleButton)
    }
}

// MARK: - Button Configurator
private extension AuthThirdPartyView {
    func getButtonConfiguration(title: String, imageName: String) -> UIButton.Configuration {
        var buttonConfig = UIButton.Configuration.plain()

        let buttonFont = UIFont(name: Fonts.ralewayBold.rawValue, size: 14) ?? .systemFont(ofSize: 14)

        let attributedTitle = NSAttributedString(string: title, attributes: [
            .font: buttonFont,
            .foregroundColor: UIColor.white
        ])
        buttonConfig.attributedTitle = AttributedString(attributedTitle)

        let buttonImage = UIImage(named: imageName)
        buttonConfig.image = buttonImage

        buttonConfig.baseBackgroundColor = .white
        buttonConfig.imagePadding = 16

        return buttonConfig
    }

    func applyBorderStylesToButton(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
    }
}
