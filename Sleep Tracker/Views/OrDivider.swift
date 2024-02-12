//
//  OrDivider.swift
//  Sleep Tracker
//
//  Created by Dima Y on 12.02.2024.
//

import UIKit

class OrDivider: UIView {
    private lazy var orLabel: UILabel = {
        let label = UILabel()

        label.textColor = .grey20
        label.font = UIFont(name: Fonts.ralewayBold.rawValue, size: 12)
        label.text = "or"

        return label
    }()

    private lazy var rightLine: UIView = {
        let view = UIView()

        view.backgroundColor = .grey20

        return view
    }()

    private lazy var leftLine: UIView = {
        let view = UIView()

        view.backgroundColor = .grey20

        return view
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal
        stackView.spacing = 16

        return stackView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension OrDivider {
    func setupLayout() {
        leftLine.translatesAutoresizingMaskIntoConstraints = false
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLine.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(leftLine)
        self.addSubview(orLabel)
        self.addSubview(rightLine)

        NSLayoutConstraint.activate([
                   leftLine.topAnchor.constraint(equalTo: topAnchor),
                   leftLine.bottomAnchor.constraint(equalTo: bottomAnchor),
                   leftLine.leadingAnchor.constraint(equalTo: leadingAnchor),
                   leftLine.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -16.0),
                   leftLine.heightAnchor.constraint(equalToConstant: 1),

                   orLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                   orLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

                   rightLine.topAnchor.constraint(equalTo: topAnchor),
                   rightLine.bottomAnchor.constraint(equalTo: bottomAnchor),
                   rightLine.trailingAnchor.constraint(equalTo: trailingAnchor),
                   rightLine.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 16.0),
                   rightLine.heightAnchor.constraint(equalToConstant: 1)
               ])
    }
}
