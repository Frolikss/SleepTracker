//
//  LogoView.swift
//  Sleep Tracker
//
//  Created by Dima Y on 12.02.2024.
//

import UIKit

class LogoView: UIView {
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()

        let logoImage = UIImage(named: "logo")

        imageView.image = logoImage
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
}

// MARK: - Setup UI && Layout
private extension LogoView {
    func setupLayout() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(logoImageView)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 128.0),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor)
        ])
    }
}
