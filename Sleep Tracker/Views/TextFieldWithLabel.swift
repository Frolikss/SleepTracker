//
//  TextField.swift
//  Sleep Tracker
//
//  Created by Dima Y on 13.02.2024.
//

import UIKit

class TextFieldWithLabel: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 14)
        label.textColor = .white

        return label
    }()

    private lazy var textField: TextField = {
        let textField = TextField()

        textField.font = UIFont(name: Fonts.ralewayMedium.rawValue, size: 14)
        textField.textColor = .white

        textField.borderStyle = .roundedRect
        textField.backgroundColor = .grey95

        return textField
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 8

        return stackView
    }()

    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        titleLabel.text = title

        let attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
            .foregroundColor: UIColor.grey40])

        textField.attributedPlaceholder = attributedPlaceholder
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        setupLayout()
    }

    public func setupDelegate(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
}

// MARK: - Setup UI && Layout
private extension TextFieldWithLabel {
    func setupLayout() {
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(textField)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func setupUI() {
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
    }
}
