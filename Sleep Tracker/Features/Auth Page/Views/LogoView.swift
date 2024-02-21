//
//  LogoView.swift
//  Sleep Tracker
//
//  Created by Dima Y on 12.02.2024.
//

import UIKit

class LogoView: UIView {
    private let imageSize: CGSize
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()

        let logoImage = UIImage(named: "logo")

        imageView.image = logoImage
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    init(imageSize: CGSize = CGSize(width: 128.0, height: 128.0)) {
        self.imageSize = imageSize
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
            logoImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            logoImageView.heightAnchor.constraint(equalToConstant: imageSize.height)
        ])
    }
}
