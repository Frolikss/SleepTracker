//
//  SubOnboardingViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

class SubOnboardingViewController: UIViewController {
    private lazy var onboardImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 28)
        label.numberOfLines = 0
        label.textColor = .white
        label.setLineHeight(lineHeightRatio: 1.2)
        label.textAlignment = .center

        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayMedium.rawValue, size: 16)
        label.numberOfLines = 0
        label.textColor = .grey20
        label.setLineHeight(lineHeightRatio: 1.4)
        label.textAlignment = .center

        return label
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 32

        return stackView
    }()

    init(imageName: String, title: String, subTitle: String?) {
        super.init(nibName: nil, bundle: nil)

        onboardImageView.image = UIImage(named: imageName)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        setupUI()
    }
}

// MARK: - Setup UI
private extension SubOnboardingViewController {
    func setupUI() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subTitleLabel)

        onboardImageView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textStackView.setContentHuggingPriority(.defaultLow, for: .vertical)

        contentStackView.addArrangedSubview(onboardImageView)
        contentStackView.addArrangedSubview(textStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

            onboardImageView.heightAnchor.constraint(equalToConstant: 330),
            onboardImageView.widthAnchor    .constraint(lessThanOrEqualToConstant: 350)
        ])
    }
}
