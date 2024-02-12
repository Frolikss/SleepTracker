//
//  AuthViewController.swift
//  Sleep Tracker
//
//  Created by Dima Y on 10.02.2024.
//

import UIKit

class AuthViewController: UIViewController {

    override func loadView() {
        super.loadView()
        let label = UILabel()

        label.text = "Auth page"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        self.view.backgroundColor = .lightGray
    }

}
